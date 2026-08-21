import 'package:isar/isar.dart';
import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/shared/data/database/collections/license_collection.dart';
import 'package:study_planner/shared/data/datasources/supabase_activation_data_source.dart';
import 'package:study_planner/shared/data/repositories/mappers/license_mapper.dart';
import 'package:study_planner/shared/domain/entities/activation_result.dart';
import 'package:study_planner/shared/domain/entities/license.dart';
import 'package:study_planner/shared/domain/enums/license_status.dart';
import 'package:study_planner/shared/domain/enums/license_type.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  LicenseRepositoryImpl({
    required Isar isar,
    required SupabaseActivationDataSource activationDataSource,
  })  : _isar = isar,
        _activationDataSource = activationDataSource;

  final Isar _isar;
  final SupabaseActivationDataSource _activationDataSource;

  // ── Local Isar reads/writes ───────────────────────────────────────────────

  @override
  Future<License?> getLocalLicense() async {
    try {
      final collection = await _isar.licenseCollections.get(
        DatabaseConstants.singletonId,
      );
      if (collection == null) return null;
      return LicenseMapper.toDomain(collection);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isActivated() async {
    try {
      // Use synchronous read so GoRouter _redirect doesn't have to await
      // an async Isar query on every navigation event.
      final collection = _isar.licenseCollections.getSync(
        DatabaseConstants.singletonId,
      );
      return collection != null &&
          collection.status == LicenseStatus.active;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> saveLocalLicense(License license) async {
    try {
      final collection = LicenseMapper.toCollection(license);
      await _isar.writeTxn(() async {
        await _isar.licenseCollections.put(collection);
      });
    } catch (_) {
      // Swallow — caller handles ActivationPartialFailure.
    }
  }

  @override
  Future<void> clearLocalLicense() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.licenseCollections.delete(DatabaseConstants.singletonId);
      });
    } catch (_) {}
  }

  // ── Activation (requires internet) ───────────────────────────────────────

  @override
  Future<ActivationResult> activate(String rawCode) async {
    // 1 — Local format validation (no network needed).
    final normalised = SupabaseActivationDataSource.normalise(rawCode);
    if (!SupabaseActivationDataSource.isValidFormat(normalised)) {
      return ActivationInvalidCode();
    }

    // 2 — Call the Supabase RPC atomically.
    final rpcResult = await _activationDataSource.redeemCode(rawCode);

    // 3 — Map RPC result to domain result.
    switch (rpcResult) {
      case SupabaseRedemptionInvalidCode():
        return ActivationInvalidCode();

      case SupabaseRedemptionAlreadyUsed():
        return ActivationAlreadyUsed();

      case SupabaseRedemptionNoInternet():
        return ActivationNoInternet();

      case SupabaseRedemptionServerError(detail: final detail):
        return ActivationServerError(detail);

      case SupabaseRedemptionSuccess(
          activationId: final activationId,
          activatedAt: final activatedAt,
        ):
        // 4 — Server succeeded.  Attempt local Isar write.
        final now = DateTime.now();
        final license = License(
          activationId: activationId,
          type: LicenseType.student,
          status: LicenseStatus.active,
          activatedAt: activatedAt,
          createdAt: now,
        );

        // Guard against double-tapping: if already saved, return success.
        final existing = await getLocalLicense();
        if (existing?.activationId == activationId) {
          return ActivationSuccess(existing!);
        }

        await saveLocalLicense(license);

        // 5 — Verify the write actually persisted.
        final saved = await getLocalLicense();
        if (saved == null) {
          // Partial failure: server consumed the code but local write failed.
          return ActivationPartialFailure(activationId, activatedAt);
        }

        return ActivationSuccess(saved);
    }
  }

  // ── Recovery ─────────────────────────────────────────────────────────────

  @override
  Future<void> recoverActivation({
    required String activationId,
    required DateTime activatedAt,
  }) async {
    final license = License(
      activationId: activationId,
      type: LicenseType.student,
      status: LicenseStatus.active,
      activatedAt: activatedAt,
      createdAt: DateTime.now(),
    );
    await saveLocalLicense(license);
  }
}

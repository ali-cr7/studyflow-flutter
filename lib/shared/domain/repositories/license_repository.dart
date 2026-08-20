import 'package:study_planner/shared/domain/entities/activation_result.dart';
import 'package:study_planner/shared/domain/entities/license.dart';

abstract interface class LicenseRepository {
  /// Returns the locally stored license, or `null` if the app has never been
  /// successfully activated on this device.
  Future<License?> getLocalLicense();

  /// Convenience: `true` iff a local license exists and its status is active.
  Future<bool> isActivated();

  /// Attempts to redeem [rawCode] against Supabase (requires internet).
  ///
  /// The code is normalised (trimmed, uppercased) and hashed before being
  /// sent so no plain-text code leaves the device.
  ///
  /// Returns an [ActivationResult] discriminated union — never throws.
  Future<ActivationResult> activate(String rawCode);

  /// Persists [license] to the local Isar store.
  Future<void> saveLocalLicense(License license);

  /// Recovery path for edge-case [ActivationPartialFailure]:
  /// the server already issued [activationId] but the local write failed.
  /// Calling this writes the local Isar record without contacting Supabase.
  Future<void> recoverActivation({
    required String activationId,
    required DateTime activatedAt,
  });

  /// Clears the local license record (for testing / factory reset).
  Future<void> clearLocalLicense();
}

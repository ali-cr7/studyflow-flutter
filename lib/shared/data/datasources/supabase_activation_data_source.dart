import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The shape of a successful RPC response from `redeem_activation_code`.
class _RedeemSuccess {
  _RedeemSuccess({required this.activationId, required this.activatedAt});

  final String activationId;
  final DateTime activatedAt;

  factory _RedeemSuccess.fromMap(Map<String, dynamic> m) {
    return _RedeemSuccess(
      activationId: m['activation_id'] as String,
      activatedAt: DateTime.parse(m['activated_at'] as String).toLocal(),
    );
  }
}

/// Possible outcomes of the RPC call (before mapping to domain results).
sealed class _RpcOutcome {}

final class _RpcSuccess extends _RpcOutcome {
  _RpcSuccess(this.data);
  final _RedeemSuccess data;
}

final class _RpcInvalidCode extends _RpcOutcome {}

final class _RpcAlreadyUsed extends _RpcOutcome {}

final class _RpcNoInternet extends _RpcOutcome {}

final class _RpcServerError extends _RpcOutcome {
  _RpcServerError([this.detail]);
  final String? detail;
}

/// Communicates exclusively with Supabase for activation-code redemption.
///
/// Responsibilities:
/// - Normalise the raw code (trim + uppercase).
/// - Hash it with SHA-256 before it leaves the device.
/// - Call the `redeem_activation_code` RPC atomically.
/// - Map all network / server responses to a typed [_RpcOutcome].
///
/// This class has no knowledge of Isar or Flutter widgets.
class SupabaseActivationDataSource {
  SupabaseActivationDataSource(this._client);

  final SupabaseClient _client;

  // ── Code normalisation & hashing ─────────────────────────────────────────

  /// Normalise: trim whitespace, uppercase, collapse repeated dashes.
  static String normalise(String raw) {
    return raw.trim().toUpperCase().replaceAll(RegExp(r'-+'), '-');
  }

  /// Validate the `SP-XXXX-XXXX` format locally before making a network call.
  static bool isValidFormat(String normalised) {
    return RegExp(r'^SP-[A-Z0-9]{4}-[A-Z0-9]{4}$').hasMatch(normalised);
  }

  /// SHA-256 hex digest of the normalised code.
  static String computeHash(String normalised) {
    final bytes = utf8.encode(normalised);
    return sha256.convert(bytes).toString();
  }

  // ── RPC call ──────────────────────────────────────────────────────────────

  /// Attempts to redeem [rawCode] by calling the Supabase
  /// `redeem_activation_code` RPC.
  ///
  /// Returns a typed [_RpcOutcome]. Never throws.
  Future<_RpcOutcome> _redeem(String rawCode) async {
    final normalised = normalise(rawCode);
    final codeHash = computeHash(normalised);

    try {
      final response = await _client
          .rpc('redeem_activation_code', params: {'p_code_hash': codeHash})
          .timeout(const Duration(seconds: 15));

      // The RPC returns a single JSON object.
      final map = response as Map<String, dynamic>?;
      if (map == null) return _RpcServerError('empty response');

      final status = map['status'] as String?;
      switch (status) {
        case 'success':
          return _RpcSuccess(_RedeemSuccess.fromMap(map));
        case 'invalid_code':
          return _RpcInvalidCode();
        case 'already_used':
          return _RpcAlreadyUsed();
        default:
          return _RpcServerError('unexpected status: $status');
      }
    } on SocketException {
      return _RpcNoInternet();
    } on HttpException {
      return _RpcNoInternet();
    } catch (e) {
      // Covers timeouts (TimeoutException), PostgrestException, etc.
      final msg = e.toString();
      if (msg.contains('network') ||
          msg.contains('connection') ||
          msg.contains('SocketException') ||
          msg.contains('TimeoutException')) {
        return _RpcNoInternet();
      }
      return _RpcServerError(msg);
    }
  }

  // ── Public surface exposed to the repository ──────────────────────────────

  Future<SupabaseRedemptionResult> redeemCode(String rawCode) async {
    final outcome = await _redeem(rawCode);
    return switch (outcome) {
      _RpcSuccess(data: final d) => SupabaseRedemptionSuccess(
          activationId: d.activationId,
          activatedAt: d.activatedAt,
        ),
      _RpcInvalidCode() => const SupabaseRedemptionInvalidCode(),
      _RpcAlreadyUsed() => const SupabaseRedemptionAlreadyUsed(),
      _RpcNoInternet() => const SupabaseRedemptionNoInternet(),
      _RpcServerError(detail: final detail) =>
        SupabaseRedemptionServerError(detail),
    };
  }
}

// ── Public result types ────────────────────────────────────────────────────

sealed class SupabaseRedemptionResult {
  const SupabaseRedemptionResult();
}

final class SupabaseRedemptionSuccess extends SupabaseRedemptionResult {
  const SupabaseRedemptionSuccess({
    required this.activationId,
    required this.activatedAt,
  });
  final String activationId;
  final DateTime activatedAt;
}

final class SupabaseRedemptionInvalidCode extends SupabaseRedemptionResult {
  const SupabaseRedemptionInvalidCode();
}

final class SupabaseRedemptionAlreadyUsed extends SupabaseRedemptionResult {
  const SupabaseRedemptionAlreadyUsed();
}

final class SupabaseRedemptionNoInternet extends SupabaseRedemptionResult {
  const SupabaseRedemptionNoInternet();
}

final class SupabaseRedemptionServerError extends SupabaseRedemptionResult {
  const SupabaseRedemptionServerError([this.detail]);
  final String? detail;
}

import 'package:study_planner/shared/domain/entities/license.dart';

/// The outcome of calling [LicenseRepository.activate].
sealed class ActivationResult {}

/// The code was valid, consumed atomically, and the license has been saved
/// locally.
final class ActivationSuccess extends ActivationResult {
  ActivationSuccess(this.license);
  final License license;
}

/// The code string did not match any record in the database.
final class ActivationInvalidCode extends ActivationResult {}

/// The code exists but has already been redeemed by someone.
final class ActivationAlreadyUsed extends ActivationResult {}

/// The device had no internet access at the time of the attempt.
final class ActivationNoInternet extends ActivationResult {}

/// The Supabase service returned an unexpected error (5xx, timeout, etc.).
final class ActivationServerError extends ActivationResult {
  ActivationServerError([this.detail]);
  final String? detail;
}

/// Edge-case: the RPC succeeded on the server but the client lost connectivity
/// before writing the local Isar record.  A subsequent call with the same code
/// will hit [ActivationAlreadyUsed]; the caller should offer a "recover"
/// option using [LicenseRepository.recoverActivation].
final class ActivationPartialFailure extends ActivationResult {
  /// The activationId that was issued before the local write failed.
  /// Pass this to [LicenseRepository.recoverActivation] to finish the save.
  ActivationPartialFailure(this.activationId, this.activatedAt);
  final String activationId;
  final DateTime activatedAt;
}

part of 'activation_cubit.dart';

enum ActivationStatus {
  idle,
  submitting,
  success,
  /// The code format is invalid (client-side check, no network needed).
  invalidFormat,
  invalidCode,
  alreadyUsed,
  noInternet,
  serverError,
  /// Server consumed the code but the local write failed.
  /// [recoveryActivationId] and [recoveryActivatedAt] are set.
  partialFailure,
}

class ActivationState {
  const ActivationState({
    this.status = ActivationStatus.idle,
    this.codeInput = '',
    this.recoveryActivationId,
    this.recoveryActivatedAt,
    this.serverErrorDetail,
  });

  final ActivationStatus status;
  final String codeInput;

  // ── Partial-failure recovery payload ─────────────────────────────────────
  final String? recoveryActivationId;
  final DateTime? recoveryActivatedAt;

  // ── Server error detail (never shown raw to students) ────────────────────
  final String? serverErrorDetail;

  bool get isSubmitting => status == ActivationStatus.submitting;
  bool get isRecoverable => status == ActivationStatus.partialFailure;

  /// True while the Activate button should be enabled.
  bool get canSubmit =>
      codeInput.trim().isNotEmpty && !isSubmitting;

  ActivationState copyWith({
    ActivationStatus? status,
    String? codeInput,
    String? recoveryActivationId,
    DateTime? recoveryActivatedAt,
    String? serverErrorDetail,
    bool clearRecovery = false,
  }) {
    return ActivationState(
      status: status ?? this.status,
      codeInput: codeInput ?? this.codeInput,
      recoveryActivationId: clearRecovery
          ? null
          : recoveryActivationId ?? this.recoveryActivationId,
      recoveryActivatedAt: clearRecovery
          ? null
          : recoveryActivatedAt ?? this.recoveryActivatedAt,
      serverErrorDetail: serverErrorDetail ?? this.serverErrorDetail,
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/shared/domain/entities/activation_result.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';

part 'activation_state.dart';

class ActivationCubit extends Cubit<ActivationState> {
  ActivationCubit({required LicenseRepository licenseRepository})
      : _licenseRepository = licenseRepository,
        super(const ActivationState());

  final LicenseRepository _licenseRepository;

  // ── Input handling ────────────────────────────────────────────────────────

  void updateCode(String value) {
    emit(state.copyWith(
      codeInput: value,
      status: ActivationStatus.idle,
      clearRecovery: true,
    ));
  }

  // ── Primary activation flow ───────────────────────────────────────────────

  Future<void> activate() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: ActivationStatus.submitting));

    final result = await _licenseRepository.activate(state.codeInput);

    if (isClosed) return;

    switch (result) {
      case ActivationSuccess():
        emit(state.copyWith(status: ActivationStatus.success));

      case ActivationInvalidCode():
        emit(state.copyWith(status: ActivationStatus.invalidCode));

      case ActivationAlreadyUsed():
        emit(state.copyWith(status: ActivationStatus.alreadyUsed));

      case ActivationNoInternet():
        emit(state.copyWith(status: ActivationStatus.noInternet));

      case ActivationServerError(detail: final detail):
        emit(state.copyWith(
          status: ActivationStatus.serverError,
          serverErrorDetail: detail,
        ));

      case ActivationPartialFailure(
          activationId: final id,
          activatedAt: final at,
        ):
        emit(state.copyWith(
          status: ActivationStatus.partialFailure,
          recoveryActivationId: id,
          recoveryActivatedAt: at,
        ));
    }
  }

  // ── Partial-failure recovery ──────────────────────────────────────────────
  //
  // Edge-case: the server consumed the code but the local Isar write failed.
  // The student is shown a "Retry saving" option that calls this method
  // without contacting Supabase again.

  Future<void> recoverPartialActivation() async {
    final id = state.recoveryActivationId;
    final at = state.recoveryActivatedAt;
    if (id == null || at == null) return;

    emit(state.copyWith(status: ActivationStatus.submitting));

    await _licenseRepository.recoverActivation(
      activationId: id,
      activatedAt: at,
    );

    if (isClosed) return;

    // Verify the write actually worked this time.
    final activated = await _licenseRepository.isActivated();
    if (isClosed) return;

    emit(state.copyWith(
      status: activated
          ? ActivationStatus.success
          : ActivationStatus.serverError,
      serverErrorDetail:
          activated ? null : 'Could not save activation locally.',
    ));
  }
}

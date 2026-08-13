import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/features/onboarding/data/onboarding_mapper.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

/// Orchestrates onboarding form state and persists the completed profile.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required StudentProfileRepository profileRepository,
    required AppSettingsRepository settingsRepository,
  })  : _profileRepository = profileRepository,
        _settingsRepository = settingsRepository,
        super(const OnboardingState());

  final StudentProfileRepository _profileRepository;
  final AppSettingsRepository _settingsRepository;

  void updateName(String value) {
    emit(state.copyWith(name: value, clearError: true));
  }

  void updateGrade(String? value) {
    emit(state.copyWith(grade: value, clearError: true));
  }

  void selectDailyGoal(int minutes) {
    emit(state.copyWith(
      customDailyGoalSelected: false,
      selectedDailyGoalMinutes: minutes,
      clearError: true,
    ));
  }

  void enableCustomDailyGoal() {
    emit(state.copyWith(customDailyGoalSelected: true, clearError: true));
  }

  void updateCustomDailyGoalHours(String value) {
    emit(state.copyWith(
      customDailyGoalHours: int.tryParse(value.trim()) ?? 0,
      clearError: true,
    ));
  }

  void updateCustomDailyGoalMinutesPart(String value) {
    emit(state.copyWith(
      customDailyGoalMinutesPart: int.tryParse(value.trim()) ?? 0,
      clearError: true,
    ));
  }

  void selectStudyMinutes(int minutes) {
    emit(state.copyWith(
      customStudySelected: false,
      selectedStudyMinutes: minutes,
      clearError: true,
    ));
  }

  void enableCustomStudyMinutes() {
    emit(state.copyWith(customStudySelected: true, clearError: true));
  }

  void updateCustomStudyMinutes(String value) {
    emit(state.copyWith(
      customStudyMinutes: int.tryParse(value.trim()) ?? 0,
      clearError: true,
    ));
  }

  void selectBreakMinutes(int minutes) {
    emit(state.copyWith(selectedBreakMinutes: minutes, clearError: true));
  }

  void updateWakeUpTime(DayTime value) {
    emit(state.copyWith(wakeUpTime: value, clearError: true));
  }

  void updateSleepTime(DayTime value) {
    emit(state.copyWith(sleepTime: value, clearError: true));
  }

  void toggleNotifications(bool enabled) {
    emit(state.copyWith(notificationEnabled: enabled, clearError: true));
  }

  void updateNotificationTime(TimeOfDay time) {
    emit(state.copyWith(notificationTime: time, clearError: true));
  }

  void goBack() {
    if (state.pageIndex == 0 || state.status == OnboardingStatus.submitting) {
      return;
    }
    emit(state.copyWith(pageIndex: state.pageIndex - 1, clearError: true));
  }

  Future<void> goNext() async {
    if (!state.canContinue) return;

    if (state.pageIndex >= OnboardingState.totalPages - 1) {
      await completeOnboarding();
      return;
    }

    emit(state.copyWith(pageIndex: state.pageIndex + 1, clearError: true));
  }

  Future<void> completeOnboarding() async {
    if (!state.canContinue) return;

    emit(state.copyWith(status: OnboardingStatus.submitting, clearError: true));

    try {
      await _profileRepository.saveProfile(
        OnboardingMapper.toStudentProfile(state),
      );
      await _settingsRepository.saveSettings(
        OnboardingMapper.toAppSettings(state),
      );
      emit(state.copyWith(status: OnboardingStatus.success, clearError: true));
    } catch (error) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Could not save your profile. Please try again.',
      ));
    }
  }
}

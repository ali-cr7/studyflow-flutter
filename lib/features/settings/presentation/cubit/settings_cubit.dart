import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_state.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/enums/app_language.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required StudentProfileRepository profileRepository,
    required AppSettingsRepository settingsRepository,
  }) : _profileRepository = profileRepository,
       _settingsRepository = settingsRepository,
       super(const SettingsState());

  final StudentProfileRepository _profileRepository;
  final AppSettingsRepository _settingsRepository;

  Future<void> loadSettings() async {
    try {
      final profile = await _profileRepository.getProfile();
      final settings = await _settingsRepository.getSettings();

      emit(
        state.copyWith(profile: profile, settings: settings, clearError: true),
      );
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Could not load your settings. Please try again.',
        ),
      );
    }
  }

  Future<void> updateTheme(AppThemeMode mode) async {
    await _persistSettings(state.settings.copyWith(theme: mode));
  }

  Future<void> updateNotifications(bool enabled) async {
    await _persistSettings(
      state.settings.copyWith(notificationsEnabled: enabled),
    );
  }

  Future<void> updateSoundEffects(bool enabled) async {
    await _persistSettings(state.settings.copyWith(soundEnabled: enabled));
  }

  Future<void> updateFocusSound(FocusSoundMode mode) async {
    await _persistSettings(state.settings.copyWith(focusSound: mode));
  }

  Future<void> updateStudyDuration(int minutes) async {
    if (minutes <= 0) return;
    await _persistSettings(state.settings.copyWith(studyDuration: minutes));
  }

  Future<void> updateBreakDuration(int minutes) async {
    if (minutes <= 0) return;
    await _persistSettings(state.settings.copyWith(breakDuration: minutes));
  }

  Future<void> updateLanguage(AppLanguage language) async {
    await _persistSettings(state.settings.copyWith(language: language));
  }

  Future<void> updateProfile({
    String? name,
    String? grade,
    int? dailyGoalMinutes,
  }) async {
    final currentProfile =
        state.profile ??
        StudentProfile(
          id: 1,
          name: '',
          grade: 'Other',
          dailyGoalMinutes: 120,
          wakeUpTime: const DayTime(hour: 7, minute: 0),
          sleepTime: const DayTime(hour: 22, minute: 30),
          preferredSessionDuration: state.settings.studyDuration,
        );

    final nextProfile = currentProfile.copyWith(
      name: name ?? currentProfile.name,
      grade: grade ?? currentProfile.grade,
      dailyGoalMinutes: dailyGoalMinutes ?? currentProfile.dailyGoalMinutes,
    );

    await _profileRepository.saveProfile(nextProfile);
    emit(state.copyWith(profile: nextProfile, clearError: true));
  }

  Future<void> _persistSettings(AppSettings settings) async {
    try {
      await _settingsRepository.saveSettings(settings);
      emit(state.copyWith(settings: settings, clearError: true));
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Could not save your settings. Please try again.',
        ),
      );
    }
  }
}

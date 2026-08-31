import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/enums/app_language.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';

class SettingsState {
  const SettingsState({
    this.settings = const AppSettings(
      theme: AppThemeMode.system,
      studyDuration: 25,
      breakDuration: 5,
      notificationsEnabled: true,
      soundEnabled: true,
      focusSound: FocusSoundMode.rain,
      language: AppLanguage.en,
    ),
    this.profile,
    this.isSaving = false,
    this.errorMessage,
  });

  final AppSettings settings;
  final StudentProfile? profile;
  final bool isSaving;
  final String? errorMessage;

  SettingsState copyWith({
    AppSettings? settings,
    StudentProfile? profile,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      profile: profile ?? this.profile,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

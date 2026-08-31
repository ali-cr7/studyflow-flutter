import 'package:study_planner/shared/domain/enums/app_language.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';

/// Singleton application preferences for this device.
class AppSettings {
  const AppSettings({
    required this.theme,
    required this.studyDuration,
    required this.breakDuration,
    required this.notificationsEnabled,
    required this.soundEnabled,
    required this.focusSound,
    required this.language,
  });

  final AppThemeMode theme;
  final int studyDuration;
  final int breakDuration;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final FocusSoundMode focusSound;
  final AppLanguage language;

  /// Sensible defaults for a first launch before onboarding completes.
  factory AppSettings.defaults() {
    return const AppSettings(
      theme: AppThemeMode.system,
      studyDuration: 25,
      breakDuration: 5,
      notificationsEnabled: true,
      soundEnabled: true,
      focusSound: FocusSoundMode.rain,
      language: AppLanguage.en,
    );
  }

  AppSettings copyWith({
    AppThemeMode? theme,
    int? studyDuration,
    int? breakDuration,
    bool? notificationsEnabled,
    bool? soundEnabled,
    FocusSoundMode? focusSound,
    AppLanguage? language,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      studyDuration: studyDuration ?? this.studyDuration,
      breakDuration: breakDuration ?? this.breakDuration,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      focusSound: focusSound ?? this.focusSound,
      language: language ?? this.language,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppSettings &&
        other.theme == theme &&
        other.studyDuration == studyDuration &&
        other.breakDuration == breakDuration &&
        other.notificationsEnabled == notificationsEnabled &&
        other.soundEnabled == soundEnabled &&
        other.focusSound == focusSound &&
        other.language == language;
  }

  @override
  int get hashCode => Object.hash(
    theme,
    studyDuration,
    breakDuration,
    notificationsEnabled,
    soundEnabled,
    focusSound,
    language,
  );
}

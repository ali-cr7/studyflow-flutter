import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';

/// Singleton application preferences for this device.
class AppSettings {
  const AppSettings({
    required this.theme,
    required this.studyDuration,
    required this.breakDuration,
    required this.notificationsEnabled,
    required this.soundEnabled,
  });

  final AppThemeMode theme;
  final int studyDuration;
  final int breakDuration;
  final bool notificationsEnabled;
  final bool soundEnabled;

  /// Sensible defaults for a first launch before onboarding completes.
  factory AppSettings.defaults() {
    return const AppSettings(
      theme: AppThemeMode.system,
      studyDuration: 25,
      breakDuration: 5,
      notificationsEnabled: true,
      soundEnabled: true,
    );
  }

  AppSettings copyWith({
    AppThemeMode? theme,
    int? studyDuration,
    int? breakDuration,
    bool? notificationsEnabled,
    bool? soundEnabled,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      studyDuration: studyDuration ?? this.studyDuration,
      breakDuration: breakDuration ?? this.breakDuration,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppSettings &&
        other.theme == theme &&
        other.studyDuration == studyDuration &&
        other.breakDuration == breakDuration &&
        other.notificationsEnabled == notificationsEnabled &&
        other.soundEnabled == soundEnabled;
  }

  @override
  int get hashCode => Object.hash(
        theme,
        studyDuration,
        breakDuration,
        notificationsEnabled,
        soundEnabled,
      );
}

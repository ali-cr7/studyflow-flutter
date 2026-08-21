import 'package:isar/isar.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';

part 'app_settings_collection.g.dart';

/// Singleton app preferences (`id == 1`).
@collection
class AppSettingsCollection {
  Id id = 1;

  @Enumerated(EnumType.name)
  late AppThemeMode theme;

  @Enumerated(EnumType.name)
  late FocusSoundMode focusSound;

  /// Default Pomodoro study block length in minutes.
  late int studyDuration;

  /// Default break length in minutes.
  late int breakDuration;

  late bool notificationsEnabled;

  late bool soundEnabled;
}

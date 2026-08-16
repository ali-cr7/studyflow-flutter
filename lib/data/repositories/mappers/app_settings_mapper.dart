import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/data/database/collections/app_settings_collection.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';

abstract final class AppSettingsMapper {
  static AppSettings toDomain(AppSettingsCollection collection) {
    return AppSettings(
      theme: collection.theme,
      studyDuration: collection.studyDuration,
      breakDuration: collection.breakDuration,
      notificationsEnabled: collection.notificationsEnabled,
      soundEnabled: collection.soundEnabled,
      focusSound: collection.focusSound,
    );
  }

  static AppSettingsCollection toCollection(AppSettings settings) {
    return AppSettingsCollection()
      ..id = DatabaseConstants.singletonId
      ..theme = settings.theme
      ..focusSound = settings.focusSound
      ..studyDuration = settings.studyDuration
      ..breakDuration = settings.breakDuration
      ..notificationsEnabled = settings.notificationsEnabled
      ..soundEnabled = settings.soundEnabled;
  }
}

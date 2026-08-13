import 'package:study_planner/shared/domain/entities/app_settings.dart';

/// Contract for singleton application preferences.
abstract class AppSettingsRepository {
  /// Returns saved settings, or [AppSettings.defaults] when none exist yet.
  Future<AppSettings> getSettings();

  Future<void> saveSettings(AppSettings settings);
}

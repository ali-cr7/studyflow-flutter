import 'package:isar/isar.dart';
import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/shared/data/database/collections/app_settings_collection.dart';
import 'package:study_planner/shared/data/repositories/mappers/app_settings_mapper.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<AppSettings> getSettings() async {
    try {
      final collection = await _isar.appSettingsCollections.get(
        DatabaseConstants.singletonId,
      );
      if (collection == null) return AppSettings.defaults();
      return AppSettingsMapper.toDomain(collection);
    } catch (_) {
      return AppSettings.defaults();
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    try {
      final collection = AppSettingsMapper.toCollection(settings);
      await _isar.writeTxn(() async {
        await _isar.appSettingsCollections.put(collection);
      });
    } catch (_) {
      // Keep the app usable even if the persisted settings row is stale or
      // partially migrated from an earlier schema version.
      return;
    }
  }
}

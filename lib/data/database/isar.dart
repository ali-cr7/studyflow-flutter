import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_planner/data/database/collections/collections.dart';

/// Opens and caches the single Isar instance for the app.
///
/// Call [initialize] once from `main()` before `runApp`.
class IsarDatabase {
  IsarDatabase._();

  static Isar? _instance;

  static Isar get instance {
    final isar = _instance;
    if (isar == null || !isar.isOpen) {
      throw StateError(
        'IsarDatabase.initialize() must be called before accessing instance.',
      );
    }
    return isar;
  }

  static Future<Isar> initialize({String? directory}) async {
    if (_instance != null && _instance!.isOpen) {
      return _instance!;
    }

    final path = directory ?? (await getApplicationDocumentsDirectory()).path;

    _instance = await Isar.open(
      [
        StudentProfileCollectionSchema,
        SubjectCollectionSchema,
        DailyPlanCollectionSchema,
        PlannedSubjectCollectionSchema,
        StudySessionCollectionSchema,
        ActiveTimerCollectionSchema,
        AchievementCollectionSchema,
        AppSettingsCollectionSchema,
        LicenseCollectionSchema,
      ],
      directory: path,
      name: 'study_planner_v2',
    );

    return _instance!;
  }

  static Future<void> close() async {
    if (_instance?.isOpen ?? false) {
      await _instance!.close();
    }
    _instance = null;
  }
}

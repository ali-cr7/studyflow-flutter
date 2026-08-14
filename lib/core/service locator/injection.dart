import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:study_planner/data/database/isar.dart';
import 'package:study_planner/data/repositories/achievement_repository_impl.dart';
import 'package:study_planner/data/repositories/app_settings_repository_impl.dart';
import 'package:study_planner/data/repositories/daily_plan_repository_impl.dart';
import 'package:study_planner/data/repositories/student_profile_repository_impl.dart';
import 'package:study_planner/data/repositories/study_session_repository_impl.dart';
import 'package:study_planner/data/repositories/subject_repository_impl.dart';
import 'package:study_planner/shared/domain/repositories/repositories.dart';

final getIt = GetIt.instance;

/// Registers all repositories and shared services.
///
/// Must run after [IsarDatabase.initialize].
Future<void> setupDependencies() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerSingleton<Isar>(IsarDatabase.instance);
  }

  final isar = getIt<Isar>();

  getIt
    ..registerLazySingleton<StudentProfileRepository>(
      () => StudentProfileRepositoryImpl(isar),
    )
    ..registerLazySingleton<SubjectRepository>(
      () => SubjectRepositoryImpl(isar),
    )
    ..registerLazySingleton<DailyPlanRepository>(
      () => DailyPlanRepositoryImpl(isar),
    )
    ..registerLazySingleton<StudySessionRepository>(
      () => StudySessionRepositoryImpl(isar),
    )
    ..registerLazySingleton<AchievementRepository>(
      () => AchievementRepositoryImpl(isar),
    )
    ..registerLazySingleton<AppSettingsRepository>(
      () => AppSettingsRepositoryImpl(isar),
    );
}

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:study_planner/core/services/achievement_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_planner/core/services/sound_service.dart';
import 'package:study_planner/core/services/study_timer_background_service.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/shared/data/database/isar.dart';
import 'package:study_planner/shared/data/datasources/supabase_activation_data_source.dart';
import 'package:study_planner/shared/data/repositories/achievement_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/active_timer_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/app_settings_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/daily_plan_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/license_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/student_profile_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/study_session_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/subject_repository_impl.dart';
import 'package:study_planner/features/statistics/data/repositories/statistics_repository.dart';
import 'package:study_planner/features/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';
import 'package:study_planner/shared/domain/repositories/repositories.dart';

final getIt = GetIt.instance;

/// Registers all repositories and shared services.
///
/// Must run after [IsarDatabase.initialize] and [Supabase.initialize].
Future<void> setupDependencies() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerSingleton<Isar>(IsarDatabase.instance);
  }

  final isar = getIt<Isar>();

  // ── Supabase client ──────────────────────────────────────────────────────
  // Supabase.initialize() has already been called in main() before this runs.
  if (!getIt.isRegistered<SupabaseClient>()) {
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  }

  // ── Activation data source ───────────────────────────────────────────────
  getIt.registerLazySingleton<SupabaseActivationDataSource>(
    () => SupabaseActivationDataSource(getIt<SupabaseClient>()),
  );

  // ── Domain repositories ──────────────────────────────────────────────────
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
    ..registerLazySingleton<ActiveTimerRepository>(
      () => ActiveTimerRepositoryImpl(isar),
    )
    ..registerLazySingleton<AchievementRepository>(
      () => AchievementRepositoryImpl(isar),
    )
    ..registerLazySingleton<AppSettingsRepository>(
      () => AppSettingsRepositoryImpl(isar),
    )
    ..registerLazySingleton<LicenseRepository>(
      () => LicenseRepositoryImpl(
        isar: isar,
        activationDataSource: getIt<SupabaseActivationDataSource>(),
      ),
    )
    // ── Services ─────────────────────────────────────────────────────────
    ..registerLazySingleton<TimerNotificationService>(
      TimerNotificationService.new,
    )
    ..registerLazySingleton<SoundService>(SoundService.new)
    ..registerLazySingleton<StudyTimerBackgroundService>(
      () => StudyTimerBackgroundService(
        notificationService: getIt<TimerNotificationService>(),
      ),
    )
    ..registerLazySingleton<StudyTimerService>(
      () => StudyTimerService(
        activeTimerRepository: getIt<ActiveTimerRepository>(),
        sessionRepository: getIt<StudySessionRepository>(),
        dailyPlanRepository: getIt<DailyPlanRepository>(),
        settingsRepository: getIt<AppSettingsRepository>(),
        subjectRepository: getIt<SubjectRepository>(),
        notificationService: getIt<TimerNotificationService>(),
        studentProfileRepository: getIt<StudentProfileRepository>(),
        backgroundService: getIt<StudyTimerBackgroundService>(),
      ),
    )
    ..registerLazySingleton<AchievementService>(
      () => AchievementService(
        achievementRepository: getIt<AchievementRepository>(),
        studySessionRepository: getIt<StudySessionRepository>(),
        appSettingsRepository: getIt<AppSettingsRepository>(),
      ),
    )
    ..registerLazySingleton<StatisticsRepository>(
      () => StatisticsRepositoryImpl(
        studentProfileRepository: getIt<StudentProfileRepository>(),
        subjectRepository: getIt<SubjectRepository>(),
        dailyPlanRepository: getIt<DailyPlanRepository>(),
        studySessionRepository: getIt<StudySessionRepository>(),
        achievementRepository: getIt<AchievementRepository>(),
        appSettingsRepository: getIt<AppSettingsRepository>(),
      ),
    );
}

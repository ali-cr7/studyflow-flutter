import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/services/study_timer_background_service.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/core/theme.dart';
import 'package:study_planner/shared/data/database/isar.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SUPABASE CONFIGURATION
//
// Replace the two constants below with your actual project values.
// These are the PUBLISHABLE keys — safe to embed in client code.
// NEVER put the service-role / secret key here.
//
// Find them in: Supabase Dashboard → Project Settings → API
// ─────────────────────────────────────────────────────────────────────────────
const _supabaseUrl = 'https://wsqyhdvyejjcefhlsagm.supabase.co';
const _supabasePublishableKey = 'sb_publishable_VGOFfXxUqMVXwlQAzaVSZQ__8qqEbgA';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Local database — must come before anything that touches repositories.
  await IsarDatabase.initialize();

  // 2. Supabase — initialised early so the SupabaseClient singleton is ready
  //    when setupDependencies() registers the SupabaseActivationDataSource.
  //    The app works fully offline after activation; Supabase is only called
  //    once per device (during code redemption).
  await Supabase.initialize(url: _supabaseUrl, publishableKey: _supabasePublishableKey);

  // 3. GetIt DI — registers all repositories and services.
  await setupDependencies();

  // 4. Notification + background timer setup (existing, unchanged).
  await getIt<TimerNotificationService>().initialize();
  await getIt<StudyTimerBackgroundService>().configure();
  await getIt<StudyTimerService>().reconcile();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(getIt<StudyTimerService>().reconcile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(
        profileRepository: getIt<StudentProfileRepository>(),
        settingsRepository: getIt<AppSettingsRepository>(),
      )..loadSettings(),
      child: BlocBuilder<SettingsCubit, dynamic>(
        builder: (context, state) {
          final themeMode = _themeModeFromSettings(state.settings.theme);

          return MaterialApp.router(
            
            debugShowCheckedModeBanner: false,
            title: 'StudyFlow',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }

  ThemeMode _themeModeFromSettings(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
      AppThemeMode.system => ThemeMode.system,
    };
  }
}

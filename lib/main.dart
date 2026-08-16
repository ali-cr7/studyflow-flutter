import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/theme.dart';
import 'package:study_planner/data/database/isar.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase.initialize();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }
}

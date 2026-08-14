import 'package:flutter/material.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/theme.dart';
import 'package:study_planner/data/database/isar.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'StudyFlow',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}

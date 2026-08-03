import 'package:flutter/material.dart';
import 'package:study_planner/app.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyFlow',
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      themeMode: ThemeMode.system,
      home: const StudyFlowApp(),
    );
  }
}

// class StudyFlowApp extends StatelessWidget {
//   const StudyFlowApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'StudyFlow',
//       theme: AppTheme.light,
//       darkTheme: AppTheme.dark,
//       themeMode: ThemeMode.system,
//       home: const ThemePreviewScreen(),
//     );
//   }
// }
class ThemePreviewScreen extends StatelessWidget {
  const ThemePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Monday, August 3, 2026',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: context.sfColors.mutedForeground,
        ),
      ),
    );
  }
}

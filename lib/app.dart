import 'package:flutter/material.dart';
import 'package:study_planner/core/theme.dart';

import 'package:study_planner/features/ThemePreviewScreen.dart';

class StudyFlowApp extends StatefulWidget {
  const StudyFlowApp({super.key});

  @override
  State<StudyFlowApp> createState() => _StudyFlowAppState();
}

class _StudyFlowAppState extends State<StudyFlowApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleThemeMode() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: ThemePreviewUI(
        themeMode: _themeMode,
        onToggleTheme: _toggleThemeMode,
      ),
    );
  }
}

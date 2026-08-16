import 'package:flutter/material.dart';
import 'package:study_planner/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_page.dart';
import 'package:study_planner/features/planner/presentation/pages/subjects_page.dart';
import 'package:study_planner/features/settings/presentation/pages/settings_page.dart';
import 'package:study_planner/features/statistics/presentation/pages/statistics_page.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _selectedIndex = 0;

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.event_note_outlined),
      selectedIcon: Icon(Icons.event_note_rounded),
      label: 'Plan',
    ),
    NavigationDestination(
      icon: Icon(Icons.school_outlined),
      selectedIcon: Icon(Icons.school_rounded),
      label: 'Subjects',
    ),
    NavigationDestination(
      icon: Icon(Icons.bar_chart_outlined),
      selectedIcon: Icon(Icons.bar_chart_rounded),
      label: 'Stats',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];

  final List<Widget> _views = const [
    DashboardPage(),
    DailyPlanPage(),
    SubjectsPage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _views),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: _destinations,
      ),
    );
  }
}

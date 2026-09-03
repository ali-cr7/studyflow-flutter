import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/app_drawer.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_page.dart';
import 'package:study_planner/features/planner/presentation/pages/subjects_page.dart';
import 'package:study_planner/features/settings/presentation/pages/settings_page.dart';
import 'package:study_planner/features/statistics/presentation/pages/statistics_page.dart';
import 'package:study_planner/features/session/presentation/pages/session_page.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/repositories/active_timer_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _selectedIndex = 0;
  int _refreshCounter = 0;

  /// Notifies when a different tab is selected
  final tabIndexNotifier = ValueNotifier<int>(0);
  
  /// Notifies when the currently selected tab is tapped again (refresh request)
  final refreshNotifier = ValueNotifier<int>(0);

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
      icon: Icon(Icons.timer_outlined),
      selectedIcon: Icon(Icons.timer_rounded),
      label: 'Study',
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

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      DashboardPage(
        tabIndexNotifier: tabIndexNotifier,
        refreshNotifier: refreshNotifier,
      ),
      DailyPlanPage(
        tabIndexNotifier: tabIndexNotifier,
        refreshNotifier: refreshNotifier,
      ),
      const SizedBox.shrink(),
      SubjectsPage(
        tabIndexNotifier: tabIndexNotifier,
        refreshNotifier: refreshNotifier,
      ),
      StatisticsPage(
        tabIndexNotifier: tabIndexNotifier,
        refreshNotifier: refreshNotifier,
      ),
      SettingsPage(
        tabIndexNotifier: tabIndexNotifier,
        refreshNotifier: refreshNotifier,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _views),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) async {
          if (index == 2) {
            await _openStudySession(context);
            return;
          }
          if (index == _selectedIndex) {
            // Same tab tapped again - trigger refresh
            _refreshCounter++;
            refreshNotifier.value = _refreshCounter;
          } else {
            // Different tab selected
            setState(() => _selectedIndex = index);
            tabIndexNotifier.value = index;
          }
        },
        destinations: _destinations,
      ),
    );
  }

  Future<void> _openStudySession(BuildContext context) async {
    final activeTimer = await getIt<ActiveTimerRepository>().getActiveTimer();
    if (!context.mounted) return;

    if (activeTimer != null && activeTimer.phase != ActiveTimerPhase.idle) {
      final subject = await getIt<SubjectRepository>().getById(
        activeTimer.subjectId,
      );
      if (!context.mounted) return;

      if (subject != null) {
        final plannedMinutes = (activeTimer.plannedDurationSeconds / 60).ceil();
        context.push(
          AppRoutes.session,
          extra: SessionRouteArgs(
            subject: subject,
            plannedMinutes: plannedMinutes,
          ),
        );
        return;
      }
    }

    setState(() => _selectedIndex = 1);
  }
}

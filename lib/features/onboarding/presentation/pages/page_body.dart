import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/pages/academic_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/notifications_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/preferences_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/profile_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/study_goal_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/summary_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/welcome_page.dart';

class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.pageIndex,
    required this.theme,
    required this.scheme,
    required this.colors,
  });

  final int pageIndex;
  final ThemeData theme;
  final ColorScheme scheme;
  final StudyFlowColors colors;

  @override
  Widget build(BuildContext context) {
    return switch (pageIndex) {
      0 => WelcomePage(theme: theme, scheme: scheme, colors: colors),
      1 => ProfilePage(theme: theme, scheme: scheme, colors: colors),
      2 => AcademicPage(theme: theme, scheme: scheme, colors: colors),
      3 => StudyGoalPage(theme: theme, scheme: scheme, colors: colors),
      4 => PreferencesPage(theme: theme, scheme: scheme, colors: colors),
      5 => NotificationsPage(theme: theme, scheme: scheme, colors: colors),
      6 => SummaryPage(theme: theme, scheme: scheme, colors: colors),
      _ => const SizedBox.shrink(),
    };
  }
}

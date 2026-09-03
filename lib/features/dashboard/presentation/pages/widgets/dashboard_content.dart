import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/app_drawer.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/widgets/application_drawer.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/daily_phrase_card.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_row.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key, required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = state.profile!;
    final settings = state.settings!;
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Scaffold(
      drawer: ApplicationDrawer(),
      appBar: AppBar(title: Text(l10n.dashboardTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(l10n, profile.name),
              style: theme.textTheme.displaySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.readyToReachGoals,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 16),
            DailyPhraseCard(name: profile.name),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.radiusLg),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.studyPlanSummary,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DashboardRow(label: l10n.grade, value: profile.grade),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: l10n.dailyGoal,
                      value: _formatMinutes(profile.dailyGoalMinutes),
                    ),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: l10n.sessionLength,
                      value: '${settings.studyDuration} ${l10n.min}',
                    ),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: l10n.breakDuration,
                      value: '${settings.breakDuration} ${l10n.min}',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200),
              decoration: BoxDecoration(
                color: colors.primaryLight,
                borderRadius: BorderRadius.circular(AppColors.radiusLg),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.todaysFocus, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Text(
                    l10n.focusForMinutes(
                      settings.studyDuration,
                      settings.breakDuration,
                    ),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Icon(
                      Icons.bookmark_outline,
                      size: 66,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getGreeting(AppLocalizations l10n, String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return l10n.goodMorning(name);
    } else if (hour < 18) {
      return l10n.goodAfternoon(name);
    } else {
      return l10n.goodEvening(name);
    }
  }

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }
}
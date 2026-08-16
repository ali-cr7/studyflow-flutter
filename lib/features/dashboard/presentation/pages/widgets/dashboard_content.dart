import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_row.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key, required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final profile = state.profile!;
    final settings = state.settings!;
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, ${profile.name}',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Ready to reach your study goals today?',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
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
                      'Study plan summary',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DashboardRow(label: 'Grade', value: profile.grade),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: 'Daily goal',
                      value: _formatMinutes(profile.dailyGoalMinutes),
                    ),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: 'Session length',
                      value: '${profile.preferredSessionDuration} min',
                    ),
                    const SizedBox(height: 10),
                    DashboardRow(
                      label: 'Break duration',
                      value: '${settings.breakDuration} min',
                    ),
                    const SizedBox(height: 10),
                    // DashboardRow(
                    //   label: 'Wake up',
                    //   value: _formatDayTime(profile.wakeUpTime),
                    // ),
                    // const SizedBox(height: 10),
                    // DashboardRow(
                    //   label: 'Sleep',
                    //   value: _formatDayTime(profile.sleepTime),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.primaryLight,
                  borderRadius: BorderRadius.circular(AppColors.radiusLg),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today’s focus', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Text(
                      'Focus for ${settings.studyDuration} minutes, then take ${settings.breakDuration} minutes to recharge.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.primaryDark,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Icon(
                        Icons.bookmark_outline,
                        size: 88,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: FilledButton.icon(
                    //         onPressed: () => context.go(AppRoutes.subjects),
                    //         icon: const Icon(Icons.school_outlined),
                    //         label: const Text('Subjects'),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 12),
                    //     Expanded(
                    //       child: FilledButton.icon(
                    //         onPressed: () => context.go(AppRoutes.dailyPlan),
                    //         icon: const Icon(Icons.calendar_today_outlined),
                    //         label: const Text('Daily Plan'),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }

  static String _formatDayTime(DayTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

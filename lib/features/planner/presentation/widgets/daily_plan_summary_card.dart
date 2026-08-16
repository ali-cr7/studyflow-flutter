import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class DailyPlanSummaryCard extends StatelessWidget {
  const DailyPlanSummaryCard({
    super.key,
    required this.date,
    required this.totalPlannedMinutes,
    required this.completedPlannedMinutes,
  });

  final DateTime date;
  final int totalPlannedMinutes;
  final int completedPlannedMinutes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryLight,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatDate(date), style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            '$totalPlannedMinutes min planned • $completedPlannedMinutes min completed',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final weekday = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ][date.weekday - 1];
    return '$weekday, ${date.day}/${date.month}';
  }
}

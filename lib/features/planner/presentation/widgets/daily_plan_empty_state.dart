import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class DailyPlanEmptyState extends StatelessWidget {
  const DailyPlanEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: 56,
            color: colors.mutedForeground,
          ),
          const SizedBox(height: 16),
          Text('No classes scheduled yet', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Add a subject to start building your study day.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

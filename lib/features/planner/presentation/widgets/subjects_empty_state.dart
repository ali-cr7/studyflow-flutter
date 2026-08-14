import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class SubjectsEmptyState extends StatelessWidget {
  const SubjectsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school_outlined,
              size: 52,
              color: colors.mutedForeground,
            ),
            const SizedBox(height: 12),
            Text('No subjects yet', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Add your first subject to start planning your study schedule.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

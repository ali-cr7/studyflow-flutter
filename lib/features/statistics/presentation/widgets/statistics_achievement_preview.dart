import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';

class StatisticsAchievementPreview extends StatelessWidget {
  const StatisticsAchievementPreview({super.key, required this.achievements});

  final List<String> achievements;

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return const StatisticsEmptyState(
        title: 'No achievements yet',
        message:
            'Complete study sessions and reach your goals to unlock milestones.',
      );
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: context.sfColors.border),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: achievements.map((achievement) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: context.sfColors.primaryLight,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              achievement,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

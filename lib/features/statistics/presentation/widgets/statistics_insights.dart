import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';

class StatisticsInsights extends StatelessWidget {
  const StatisticsInsights({super.key, required this.insights});

  final List<String> insights;

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) {
      return const StatisticsEmptyState(
        title: 'No insights yet',
        message:
            'Build a consistent study rhythm to unlock personalized insights.',
      );
    }

    return Column(
      children: insights.map((insight) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.sfColors.primaryLight,
              borderRadius: BorderRadius.circular(AppColors.radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.insights_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    insight,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

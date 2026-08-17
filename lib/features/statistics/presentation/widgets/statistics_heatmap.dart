import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class StatisticsHeatmap extends StatelessWidget {
  const StatisticsHeatmap({
    super.key,
    required this.activeDays,
    required this.longestStreak,
  });

  final int activeDays;
  final int longestStreak;

  @override
  Widget build(BuildContext context) {
    final cells = [
      0,
      1,
      0,
      2,
      3,
      1,
      0,
      2,
      3,
      1,
      0,
      2,
      4,
      1,
      1,
      0,
      2,
      3,
      4,
      2,
      1,
      0,
      1,
      0,
      3,
      2,
      1,
      0,
      2,
      3,
      4,
      2,
      1,
      0,
      2,
      1,
      0,
      2,
      1,
      0,
      3,
      2,
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(color: context.sfColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$activeDays active days',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Longest streak $longestStreak',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.sfColors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            itemCount: cells.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final intensity = cells[index];
              final color = switch (intensity) {
                0 => context.sfColors.muted,
                1 => context.sfColors.primaryLight,
                2 => context.sfColors.chart1.withValues(alpha: 0.55),
                3 => context.sfColors.chart2.withValues(alpha: 0.7),
                _ => context.sfColors.success,
              };
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

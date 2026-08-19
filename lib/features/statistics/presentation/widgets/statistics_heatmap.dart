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
          LayoutBuilder(
            builder: (context, constraints) {
              final cellSize = ((constraints.maxWidth - 36) / 7).clamp(
                12.0,
                24.0,
              );

              return Wrap(
                spacing: 6,
                runSpacing: 6,
                children: List.generate(cells.length, (index) {
                  final intensity = cells[index];
                  final color = switch (intensity) {
                    0 => context.sfColors.muted,
                    1 => context.sfColors.primaryLight,
                    2 => context.sfColors.chart1.withValues(alpha: 0.55),
                    3 => context.sfColors.chart2.withValues(alpha: 0.7),
                    _ => context.sfColors.success,
                  };
                  return Container(
                    width: cellSize,
                    height: cellSize,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

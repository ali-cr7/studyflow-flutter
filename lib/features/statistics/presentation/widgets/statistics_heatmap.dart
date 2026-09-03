import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';

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
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.activeDaysCount(activeDays),
                style: theme.textTheme.titleMedium,
              ),
              Text(
                l10n.longestStreak(longestStreak),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
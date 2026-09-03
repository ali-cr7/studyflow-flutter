import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsInsights extends StatelessWidget {
  const StatisticsInsights({super.key, required this.insights});

  final List<String> insights;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    if (insights.isEmpty) {
      return StatisticsEmptyState(
        title: l10n.noInsightsYet,
        message: l10n.buildConsistentRhythm,
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: Text(
                    insight,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
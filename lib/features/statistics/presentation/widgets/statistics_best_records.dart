import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsBestRecords extends StatelessWidget {
  const StatisticsBestRecords({super.key, required this.records});

  final List<BestRecord> records;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    if (records.isEmpty) {
      return StatisticsEmptyState(
        title: l10n.noRecordsYet,
        message: l10n.keepStudyingForRecords,
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
        children: records.map((record) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
                Text(
                  record.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
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
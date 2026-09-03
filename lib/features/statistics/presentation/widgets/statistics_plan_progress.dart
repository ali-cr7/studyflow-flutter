import 'package:flutter/material.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsPlanProgress extends StatelessWidget {
  const StatisticsPlanProgress({
    super.key,
    required this.plannedSeconds,
    required this.completedSeconds,
  });

  /// Duration stored/calculated in seconds.
  final int plannedSeconds;
  final int completedSeconds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context)!;

    final safePlannedSeconds = plannedSeconds < 0 ? 0 : plannedSeconds;
    final safeCompletedSeconds = completedSeconds < 0 ? 0 : completedSeconds;

    final percent = safePlannedSeconds > 0
        ? ((safeCompletedSeconds / safePlannedSeconds) * 100).round()
        : 0;

    // Prevent the progress indicator from receiving a value > 1.
    final progress = safePlannedSeconds > 0
        ? (safeCompletedSeconds / safePlannedSeconds).clamp(0.0, 1.0)
        : 0.0;

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
              Flexible(
                child: Text(
                  l10n.planCompletion,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.percent(percent),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: colors.muted,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.plannedFormat(_formatDuration(safePlannedSeconds)),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.completedLabel(_formatDuration(safeCompletedSeconds)),
                  textAlign: TextAlign.end,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Formats a duration stored in seconds for display.
  static String _formatDuration(int seconds) {
    final totalMinutes = seconds ~/ 60;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }

    if (hours > 0) {
      return '${hours}h';
    }

    return '${minutes}m';
  }
}

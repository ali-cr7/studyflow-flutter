import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsBestRecords extends StatelessWidget {
  const StatisticsBestRecords({super.key, required this.records});

  final StatisticsBestRecordsData records;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();

    if (records.isEmpty) {
      return StatisticsEmptyState(
        title: l10n.noRecordsYet,
        message: l10n.keepStudyingForRecords,
      );
    }

    final rows = _buildRows(records, l10n, locale);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        children: rows.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
                Text(
                  row.value,
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

  /// Builds the four record rows with localized labels and formatted values.
  static List<_RecordRow> _buildRows(
    StatisticsBestRecordsData records,
    AppLocalizations l10n,
    String locale,
  ) {
    return [
      // Row 1 — Longest streak
      _RecordRow(
        label: l10n.longestStreakRecord,
        value: records.longestStreakDays != null
            ? '${records.longestStreakDays}d'
            : l10n.na,
      ),

      // Row 2 — Most productive day (weekday name, locale-aware)
      _RecordRow(
        label: l10n.mostProductiveDay,
        value: records.mostProductiveDay != null
            ? intl.DateFormat.EEEE(locale).format(records.mostProductiveDay!)
            : l10n.na,
      ),

      // Row 3 — Most studied subject
      _RecordRow(
        label: l10n.mostStudiedSubjectRecord,
        value: records.mostStudiedSubjectName ?? l10n.na,
      ),

      // Row 4 — Longest session (formatted duration)
      _RecordRow(
        label: l10n.longestSession,
        value: records.longestSessionSeconds != null
            ? _formatDuration(records.longestSessionSeconds!)
            : l10n.na,
      ),
    ];
  }

  /// Formats a duration stored in seconds for display.
  /// Uses locale-neutral abbreviations (h/m/s) — no l10n needed for
  /// these universal time symbols, consistent with the rest of the UI.
  static String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    if (minutes > 0 && remainingSeconds > 0) return '${minutes}m ${remainingSeconds}s';
    if (minutes > 0) return '${minutes}m';
    return '${remainingSeconds}s';
  }
}

class _RecordRow {
  const _RecordRow({required this.label, required this.value});

  final String label;
  final String value;
}

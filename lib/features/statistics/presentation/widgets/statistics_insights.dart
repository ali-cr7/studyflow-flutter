import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsInsights extends StatelessWidget {
  const StatisticsInsights({super.key, required this.insights});

  final List<StatisticsInsight> insights;

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

    // A single noSessions insight means no data yet.
    if (insights.length == 1 &&
        insights.first.type == StatisticsInsightType.noSessions) {
      return StatisticsEmptyState(
        title: l10n.noInsightsYet,
        message: l10n.noStudySessionsRecorded,
      );
    }

    final sentences = insights
        .map((insight) => _toSentence(insight, l10n))
        .whereType<String>()
        .toList();

    if (sentences.isEmpty) {
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
        children: sentences.map((sentence) {
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
                  child: Text(sentence, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Converts a structured [StatisticsInsight] into a localized sentence.
  /// Returns null for unrecognised or empty data so the caller can filter.
  static String? _toSentence(
    StatisticsInsight insight,
    AppLocalizations l10n,
  ) {
    switch (insight.type) {
      case StatisticsInsightType.noSessions:
        return l10n.noStudySessionsRecorded;

      case StatisticsInsightType.mostStudiedSubject:
        final subject = insight.subjectName ?? l10n.na;
        final period = _periodLabel(insight.period, l10n);
        return l10n.mostStudiedSubject(period, subject);

      case StatisticsInsightType.planCompletion:
        final percent = insight.percent;
        if (percent == null) return null;
        return l10n.planCompletionInsight(percent);

      case StatisticsInsightType.currentStreak:
        final count = insight.count;
        if (count == null) return null;
        return l10n.currentStreakInsight(count);

      case StatisticsInsightType.longestStreak:
        final count = insight.count;
        if (count == null) return null;
        return l10n.longestStreakInsight(count);
    }
  }

  /// Maps a [StatisticsPeriod] to the appropriate period-label string
  /// used inside insight sentences (e.g. "this week", "هذا الأسبوع").
  static String _periodLabel(
    StatisticsPeriod? period,
    AppLocalizations l10n,
  ) {
    return switch (period) {
      StatisticsPeriod.today => l10n.periodLabelToday,
      StatisticsPeriod.week => l10n.periodLabelWeek,
      StatisticsPeriod.month => l10n.periodLabelMonth,
      StatisticsPeriod.year => l10n.periodLabelYear,
      StatisticsPeriod.allTime => l10n.periodLabelAllTime,
      null => '',
    };
  }
}

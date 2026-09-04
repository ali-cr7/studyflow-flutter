import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsActivityChart extends StatelessWidget {
  const StatisticsActivityChart({
    super.key,
    required this.chartPoints,
    required this.goalMinutes,
    required this.period,
  });

  final List<ChartPoint> chartPoints;

  /// Daily-goal duration in seconds. The name is kept for API stability.
  final int goalMinutes;

  /// The currently selected period — used to decide how to format labels.
  final StatisticsPeriod period;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _maxY(),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => colors.cardForeground,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (groupIndex < 0 || groupIndex >= chartPoints.length) {
                  return null;
                }
                final point = chartPoints[groupIndex];
                final label = _formatLabel(point.label, period, locale, l10n);
                return BarTooltipItem(
                  '$label\n${_formatDuration(point.minutes)}',
                  TextStyle(color: colors.mutedForeground, fontSize: 12),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                //      rotateAngle: -45,
                reservedSize: 20,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= chartPoints.length) {
                    return const SizedBox.shrink();
                  }
                  final label = _formatLabel(
                    chartPoints[index].label,
                    period,
                    locale,
                    l10n,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.mutedForeground,
                        fontSize: 9, // optional
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: _maxY() / 4,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: colors.border, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: chartPoints.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.minutes.toDouble(),
                  color: theme.colorScheme.primary,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  double _maxY() {
    if (chartPoints.isEmpty) return 60;
    final maxVal = chartPoints
        .map((p) => p.minutes)
        .reduce((a, b) => a > b ? a : b);
    return (maxVal > 0 ? maxVal : 60).toDouble();
  }

  // ── Label formatting ────────────────────────────────────────────────────
  //
  // Converts the locale-neutral key stored in ChartPoint.label into a
  // human-readable, locale-aware string.
  //
  //   today    key='6'          → '6 AM' / '٦ ص'
  //   week     key='2026-08-19' → 'Tue' / 'الثلاثاء'
  //   month    key='0'..'4'     → 'W1'..'W5' (universal, no translation)
  //   year     key='1'..'12'    → 'Jan'..'Dec' / 'يناير'..'ديسمبر'
  //   allTime  key='1'..'12'    → same as year

  static String _formatLabel(
    String key,
    StatisticsPeriod period,
    String locale,
    AppLocalizations l10n,
  ) {
    try {
      switch (period) {
        case StatisticsPeriod.today:
          // key is a 24-h hour string: '6', '9', '12', '15', '18', '21'
          final hour = int.parse(key);
          final dt = DateTime(2000, 1, 1, hour);
          return intl.DateFormat.j(locale).format(dt); // '6 AM' / '٦ ص'

        case StatisticsPeriod.week:
          // key is an ISO-8601 date: '2026-08-19'
          final date = DateTime.parse(key);
          return intl.DateFormat.E(locale).format(date); // 'Tue' / 'الثلاثاء'

        case StatisticsPeriod.month:
          // key is a zero-based week index: '0'..'4'
          final weekIndex = int.parse(key);
          // 'W1'..'W5' — no translation needed (universal notation)
          return 'W${weekIndex + 1}';

        case StatisticsPeriod.year:
        case StatisticsPeriod.allTime:
          // key is a month number: '1'..'12'
          final month = int.parse(key);
          final dt = DateTime(2000, month);
          return intl.DateFormat.MMM(locale).format(dt); // 'Jan' / 'يناير'
      }
    } catch (_) {
      return key; // safe fallback: show the raw key
    }
  }

  /// Formats a duration stored in seconds for the bar tooltip.
  static String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    return '${minutes}m';
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsActivityChart extends StatelessWidget {
  const StatisticsActivityChart({
    super.key,
    required this.chartPoints,
    required this.goalMinutes,
  });

  final List<ChartPoint> chartPoints;
  final int goalMinutes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

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
                final point = chartPoints[groupIndex];
                return BarTooltipItem(
                  '${point.label}\n${_formatDuration(point.minutes)}',
                  TextStyle(
                    color: colors.mutedForeground,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= chartPoints.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      chartPoints[index].label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.mutedForeground,
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
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colors.border,
                strokeWidth: 1,
              );
            },
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
    final maxMinutes = chartPoints.isEmpty
        ? 0
        : chartPoints.map((p) => p.minutes).reduce((a, b) => a > b ? a : b);
    return (maxMinutes > 0 ? maxMinutes : 60).toDouble();
  }

  static String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (hours > 0 && remainingMinutes > 0) {
      return '${hours}h ${remainingMinutes}m';
    }
    if (hours > 0) return '${hours}h';
    return '${remainingMinutes}m';
  }
}
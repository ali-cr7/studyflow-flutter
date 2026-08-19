import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';

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
    if (chartPoints.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colors = context.sfColors;
    final maxY = chartPoints
        .fold<int>(0, (max, point) => point.minutes > max ? point.minutes : max)
        .toDouble();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Average ${_formatDuration(_averageSeconds(chartPoints))}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.primaryLight,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Goal ${_formatDuration(goalMinutes)}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: (maxY * 1.25).clamp(1800, 14400),
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    tooltipBorderRadius: BorderRadius.circular(12),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final value = chartPoints[groupIndex];
                      return BarTooltipItem(
                        '${value.label}\n${_formatDuration(value.minutes)}',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: goalMinutes.toDouble(),
                      color: theme.colorScheme.primary.withValues(alpha: 0.5),
                      strokeWidth: 1,
                      dashArray: [7, 6],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 8, bottom: 6),
                        labelResolver: (_) => 'Goal',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= chartPoints.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            chartPoints[index].label,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.mutedForeground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: chartPoints.asMap().entries.map((entry) {
                  final index = entry.key;
                  final point = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: point.minutes.toDouble(),
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: [
                          colors.chart1,
                          colors.chart2,
                          colors.chart3,
                          colors.chart4,
                          colors.chart5,
                          colors.primaryDark,
                          colors.success,
                        ][index % 7],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _averageSeconds(List<ChartPoint> points) {
    if (points.isEmpty) return 0;
    final total = points.fold<int>(0, (sum, point) => sum + point.minutes);
    return (total / points.length).round();
  }

  static String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    if (minutes > 0 && remainingSeconds > 0) {
      return '${minutes}m ${remainingSeconds}s';
    }
    if (minutes > 0) return '${minutes}m';
    return '${remainingSeconds}s';
  }
}

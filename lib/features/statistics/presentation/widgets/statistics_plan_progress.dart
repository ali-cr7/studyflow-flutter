import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class StatisticsPlanProgress extends StatelessWidget {
  const StatisticsPlanProgress({
    super.key,
    required this.plannedMinutes,
    required this.completedMinutes,
  });

  final int plannedMinutes;
  final int completedMinutes;

  double get completionRatio => plannedMinutes <= 0
      ? 0
      : (completedMinutes / plannedMinutes).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final percent = (completionRatio * 100).round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(color: context.sfColors.border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_formatDuration(completedMinutes)} completed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$percent%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: completionRatio >= 0.8
                      ? context.sfColors.success
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: completionRatio,
              minHeight: 14,
              backgroundColor: context.sfColors.muted,
              valueColor: AlwaysStoppedAnimation(
                completionRatio >= 0.8
                    ? context.sfColors.success
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Planned ${_formatDuration(plannedMinutes)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.sfColors.mutedForeground,
                ),
              ),
              Text(
                'Completed ${_formatDuration(completedMinutes)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.sfColors.mutedForeground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }

  static String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }

    if (hours > 0) {
      return '${hours}h';
    }

    if (minutes > 0 && remainingSeconds > 0) {
      return '${minutes}m ${remainingSeconds}s';
    }

    if (minutes > 0) {
      return '${minutes}m';
    }

    return '${remainingSeconds}s';
  }
}

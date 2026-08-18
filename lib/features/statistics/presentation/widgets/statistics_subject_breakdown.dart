import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';

class StatisticsSubjectBreakdown extends StatelessWidget {
  const StatisticsSubjectBreakdown({super.key, required this.subjects});

  final List<SubjectBreakdown> subjects;

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      return const StatisticsEmptyState(
        title: 'No subject data yet',
        message: 'Complete sessions to see your breakdown by subject.',
      );
    }

    // subject.minutes currently contains duration in SECONDS.
    final totalSeconds = subjects.fold<int>(
      0,
      (sum, item) => sum + item.minutes,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(color: context.sfColors.border, width: 1),
      ),
      child: Column(
        children: subjects.map((subject) {
          final percent = totalSeconds == 0
              ? 0
              : ((subject.minutes / totalSeconds) * 100).round().clamp(0, 100);

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subject.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '$percent%',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: context.sfColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 10,
                    backgroundColor: context.sfColors.muted,
                    valueColor: AlwaysStoppedAnimation(Color(subject.color)),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  _formatDuration(subject.minutes),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.sfColors.mutedForeground,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// The input is duration in seconds.
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

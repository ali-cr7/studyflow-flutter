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

    final total = subjects.fold<int>(0, (sum, item) => sum + item.minutes);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(color: context.sfColors.border, width: 1),
      ),
      child: Column(
        children: subjects.map((subject) {
          final percent = total == 0 ? 0 : subject.percent.clamp(0, 100);
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
                  _formatMinutes(subject.minutes),
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

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }
}

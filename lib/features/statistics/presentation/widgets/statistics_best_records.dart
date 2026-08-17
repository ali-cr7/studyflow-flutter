import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';

class StatisticsBestRecords extends StatelessWidget {
  const StatisticsBestRecords({super.key, required this.records});

  final List<BestRecord> records;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const StatisticsEmptyState(
        title: 'No records yet',
        message: 'Keep studying to unlock your best streaks and milestones.',
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: records.map((record) {
        return Container(
          width: 150,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppColors.radiusLg),
            border: Border.all(color: context.sfColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: context.sfColors.mutedForeground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                record.value,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

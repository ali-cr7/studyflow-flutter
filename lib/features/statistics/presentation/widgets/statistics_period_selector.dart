import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';

class StatisticsPeriodSelector extends StatelessWidget {
  const StatisticsPeriodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final StatisticsPeriod selected;
  final ValueChanged<StatisticsPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.sfColors;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: StatisticsPeriod.values.map((period) {
          final isSelected = selected == period;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_label(period)),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: colors.primaryLight,
              backgroundColor: theme.cardColor,
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : colors.mutedForeground,
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) => onChanged(period),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(StatisticsPeriod period) {
    switch (period) {
      case StatisticsPeriod.today:
        return 'Today';
      case StatisticsPeriod.week:
        return 'Week';
      case StatisticsPeriod.month:
        return 'Month';
      case StatisticsPeriod.year:
        return 'Year';
      case StatisticsPeriod.allTime:
        return 'All Time';
    }
  }
}

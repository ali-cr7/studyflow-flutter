import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

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
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: StatisticsPeriod.values.map((period) {
          final isSelected = period == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_labelForPeriod(period, l10n)),
              selected: isSelected,
              onSelected: (_) => onChanged(period),
              selectedColor: colors.primaryLight,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? colors.primaryDark : colors.mutedForeground,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
                side: BorderSide(
                  color: isSelected ? colors.primaryDark : colors.border,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _labelForPeriod(StatisticsPeriod period, AppLocalizations l10n) {
    return switch (period) {
      StatisticsPeriod.today => l10n.periodToday,
      StatisticsPeriod.week => l10n.periodWeek,
      StatisticsPeriod.month => l10n.periodMonth,
      StatisticsPeriod.year => l10n.periodYear,
      StatisticsPeriod.allTime => l10n.periodAllTime,
    };
  }
}
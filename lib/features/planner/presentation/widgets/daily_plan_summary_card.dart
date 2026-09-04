import 'package:flutter/material.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DailyPlanSummaryCard extends StatelessWidget {
  const DailyPlanSummaryCard({
    super.key,
    required this.date,
    required this.totalPlannedMinutes,
    required this.completedPlannedMinutes,
  });

  final DateTime date;
  final int totalPlannedMinutes;
  final int completedPlannedMinutes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context)!;

    final locale = Localizations.localeOf(context).toString();

    final formattedDate = DateFormat('EEEE, d/M', locale).format(date);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryLight,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formattedDate, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            l10n.planSummary(totalPlannedMinutes, completedPlannedMinutes),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

 
}

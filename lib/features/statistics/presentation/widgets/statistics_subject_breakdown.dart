import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsSubjectBreakdown extends StatelessWidget {
  const StatisticsSubjectBreakdown({super.key, required this.subjects});

  final List<SubjectBreakdown> subjects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    if (subjects.isEmpty) {
      return StatisticsEmptyState(
        title: l10n.noSubjectDataYet,
        message: l10n.completeSessionsForBreakdown,
      );
    }

    return Column(
      children: subjects.map((subject) {
        final percent = subject.percent;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(subject.color),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  subject.name ?? l10n.na,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.percent(percent),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
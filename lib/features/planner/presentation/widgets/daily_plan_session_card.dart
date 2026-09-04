import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

class DailyPlanSessionCard extends StatelessWidget {
  const DailyPlanSessionCard({
    super.key,
    required this.plannedSubject,
    required this.subject,
    required this.sessionNumber,
    required this.totalSessions,
    required this.onTap,
  });

  final PlannedSubject plannedSubject;
  final Subject subject;
  final int sessionNumber;
  final int totalSessions;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context)!;

    final subjectColor = Color(subject.color);
    final cubit = context.read<DailyPlanCubit>();
    final isCompleted = plannedSubject.completed;

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppColors.radiusLg),
      child: InkWell(
        onTap: isCompleted ? null : onTap,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isCompleted ? 0.65 : 1.0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(AppColors.radiusLg),
              border: Border.all(
                color: isCompleted ? colors.success : colors.border,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: subjectColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    _subjectIcon(subject.icon),
                    color: subjectColor,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      Text(
                        _sessionSummary(l10n),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.mutedForeground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    IconButton(
                      onPressed: () =>
                          cubit.togglePlannedSubject(plannedSubject),
                      icon: Icon(
                        plannedSubject.completed
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: plannedSubject.completed
                            ? colors.success
                            : colors.mutedForeground,
                      ),
                      tooltip: l10n.toggleCompletion,
                    ),

                    IconButton(
                      onPressed: () =>
                          cubit.deletePlannedSubject(plannedSubject.id),
                      icon: const Icon(Icons.delete_outline_rounded),
                      tooltip: l10n.deletePlannedSubject,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _sessionSummary(AppLocalizations l10n) {
    return l10n.sessionSummary(
      sessionNumber,
      totalSessions,
      plannedSubject.plannedMinutes,
    );
  }

  static IconData _subjectIcon(String key) {
    const map = <String, IconData>{
      'calculate': Icons.calculate_outlined,
      'science': Icons.science_outlined,
      'language': Icons.translate_outlined,
      'history': Icons.history_edu_outlined,
      'book': Icons.book_rounded,
      'palette': Icons.palette_outlined,
      'music': Icons.music_note_outlined,
      'computer': Icons.computer_outlined,
      'biotech': Icons.biotech_outlined,
      'code': Icons.code_outlined,
    };

    return map[key] ?? Icons.book_rounded;
  }
}

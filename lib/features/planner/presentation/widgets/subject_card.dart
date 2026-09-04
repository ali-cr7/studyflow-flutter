import 'package:flutter/material.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

final Map<String, IconData> subjectIcons = {
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

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.subject,
    required this.onEdit,
    required this.onDelete,
  });

  final Subject subject;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context)!;
    final subjectColor = Color(subject.color);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: subjectColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              subjectIcons[subject.icon] ?? Icons.book_rounded,
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
                const SizedBox(height: 4),
                Text(
                  l10n.studyFocus,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.editSubject,
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
                tooltip: l10n.deleteSubject,
                color: theme.colorScheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsAchievementPreview extends StatelessWidget {
  const StatisticsAchievementPreview({super.key, required this.achievements});

  final List<String> achievements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context);

    if (achievements.isEmpty) {
      return StatisticsEmptyState(
        title: l10n.noAchievementsYetStats,
        message: l10n.completeSessionsForAchievements,
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: achievements.map((achievement) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_events_rounded,
                  size: 18,
                  color: colors.accent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    achievement,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
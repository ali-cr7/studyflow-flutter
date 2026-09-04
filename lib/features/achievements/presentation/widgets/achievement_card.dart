import 'package:flutter/material.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/achievement_definition.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    super.key,
    required this.definition,
    required this.unlocked,
    this.unlockedAt,
  });

  final AchievementDefinition definition;
  final bool unlocked;
  final DateTime? unlockedAt;

  String _title(AchievementType type, AppLocalizations l10n) {
    return switch (type) {
      AchievementType.firstSession => l10n.achievementFirstStepTitle,

      AchievementType.streak3 => l10n.achievementStreak3Title,

      AchievementType.streak7 => l10n.achievementStreak7Title,

      AchievementType.streak30 => l10n.achievementStreak30Title,

      AchievementType.dailyGoalMet => l10n.achievementDailyGoalMetTitle,

      AchievementType.tenSessions => l10n.achievementTenSessionsTitle,

      AchievementType.fiftySessions => l10n.achievementFiftySessionsTitle,

      AchievementType.hundredSessions => l10n.achievementHundredSessionsTitle,
    };
  }

  String _description(AchievementType type, AppLocalizations l10n) {
    return switch (type) {
      AchievementType.firstSession => l10n.achievementFirstStepDescription,

      AchievementType.streak3 => l10n.achievementStreak3Description,

      AchievementType.streak7 => l10n.achievementStreak7Description,

      AchievementType.streak30 => l10n.achievementStreak30Description,

      AchievementType.dailyGoalMet => l10n.achievementDailyGoalMetDescription,

      AchievementType.tenSessions => l10n.achievementTenSessionsDescription,

      AchievementType.fiftySessions => l10n.achievementFiftySessionsDescription,

      AchievementType.hundredSessions =>
        l10n.achievementHundredSessionsDescription,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final l10n = AppLocalizations.of(context)!;

    final title = _title(definition.type, l10n);
    final description = _description(definition.type, l10n);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < 180;
        final isVeryCompact = width < 140;

        final padding = isVeryCompact
            ? 12.0
            : isCompact
            ? 14.0
            : 16.0;

        final iconSize = isVeryCompact
            ? 44.0
            : isCompact
            ? 48.0
            : 52.0;

        final iconInnerSize = isVeryCompact
            ? 22.0
            : isCompact
            ? 24.0
            : 26.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(AppColors.radiusXl),
            border: Border.all(
              color: unlocked
                  ? theme.colorScheme.primary.withValues(alpha: 0.25)
                  : colors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Achievement icon
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: unlocked
                      ? theme.colorScheme.primary.withValues(alpha: 0.10)
                      : colors.muted,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  definition.icon,
                  size: iconInnerSize,
                  color: unlocked
                      ? theme.colorScheme.primary
                      : colors.mutedForeground,
                ),
              ),

              SizedBox(height: isCompact ? 10 : 14),

              // Title
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: isVeryCompact
                      ? 14
                      : isCompact
                      ? 15
                      : null,
                  fontWeight: FontWeight.w700,
                  color: unlocked ? null : colors.mutedForeground,
                ),
              ),

              SizedBox(height: isCompact ? 4 : 6),

              // Description
              Expanded(
                child: Text(
                  description,
                  maxLines: isVeryCompact
                      ? 3
                      : isCompact
                      ? 4
                      : 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: isVeryCompact ? 11 : null,
                    color: colors.mutedForeground,
                    height: 1.4,
                  ),
                ),
              ),

              SizedBox(height: isCompact ? 8 : 12),

              // Status
              Row(
                children: [
                  Icon(
                    unlocked
                        ? Icons.check_circle_rounded
                        : Icons.lock_outline_rounded,
                    size: isVeryCompact ? 14 : 16,
                    color: unlocked ? colors.success : colors.mutedForeground,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      unlocked ? l10n.unlocked : l10n.locked,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: isVeryCompact ? 11 : null,
                        color: unlocked
                            ? colors.success
                            : colors.mutedForeground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

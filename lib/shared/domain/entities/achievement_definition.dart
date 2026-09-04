import 'package:flutter/material.dart';

import 'package:study_planner/shared/domain/enums/achievement_type.dart';

class AchievementDefinition {
  const AchievementDefinition({required this.type, required this.icon});

  final AchievementType type;
  final IconData icon;
}

abstract final class AchievementDefinitions {
  static const List<AchievementDefinition> all = [
    AchievementDefinition(
      type: AchievementType.firstSession,
      icon: Icons.flag_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak3,
      icon: Icons.local_fire_department_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak7,
      icon: Icons.whatshot_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak30,
      icon: Icons.bolt_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.dailyGoalMet,
      icon: Icons.emoji_events_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.tenSessions,
      icon: Icons.school_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.fiftySessions,
      icon: Icons.workspace_premium_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.hundredSessions,
      icon: Icons.military_tech_rounded,
    ),
  ];

  static AchievementDefinition get(AchievementType type) {
    return all.firstWhere((achievement) => achievement.type == type);
  }
}

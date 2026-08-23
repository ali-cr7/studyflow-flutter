import 'package:flutter/material.dart';

import 'package:study_planner/shared/domain/enums/achievement_type.dart';

class AchievementDefinition {
  const AchievementDefinition({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
  });

  final AchievementType type;
  final String title;
  final String description;
  final IconData icon;
}

class AchievementDefinitions {
  AchievementDefinitions._();

  static const List<AchievementDefinition> all = [
    AchievementDefinition(
      type: AchievementType.firstSession,
      title: 'First Step',
      description: 'Complete your first study session.',
      icon: Icons.flag_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak3,
      title: 'Getting Started',
      description: 'Maintain a 3-day study streak.',
      icon: Icons.local_fire_department_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak7,
      title: 'One Week Strong',
      description: 'Maintain a 7-day study streak.',
      icon: Icons.whatshot_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.streak30,
      title: 'Unstoppable',
      description: 'Maintain a 30-day study streak.',
      icon: Icons.bolt_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.dailyGoalMet,
      title: 'Goal Achieved',
      description: 'Reach your daily study goal.',
      icon: Icons.emoji_events_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.tenSessions,
      title: 'Dedicated Student',
      description: 'Complete 10 study sessions.',
      icon: Icons.school_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.fiftySessions,
      title: 'Study Machine',
      description: 'Complete 50 study sessions.',
      icon: Icons.workspace_premium_rounded,
    ),
    AchievementDefinition(
      type: AchievementType.hundredSessions,
      title: 'Master of Consistency',
      description: 'Complete 100 study sessions.',
      icon: Icons.military_tech_rounded,
    ),
  ];

  static AchievementDefinition get(AchievementType type) {
    return all.firstWhere(
      (achievement) => achievement.type == type,
    );
  }
}
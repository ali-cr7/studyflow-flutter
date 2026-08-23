import 'package:flutter/material.dart';
import 'package:study_planner/features/achievements/presentation/widgets/achievement_card.dart';

import 'package:study_planner/shared/domain/entities/achievement.dart';
import 'package:study_planner/shared/domain/entities/achievement_definition.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';



class AchievementGrid extends StatelessWidget {
  const AchievementGrid({
    super.key,
    required this.unlockedAchievements,
  });

  final List<Achievement> unlockedAchievements;

  bool _isUnlocked(AchievementType type) {
    return unlockedAchievements.any(
      (achievement) => achievement.type == type,
    );
  }

  DateTime? _unlockedAt(AchievementType type) {
    for (final achievement in unlockedAchievements) {
      if (achievement.type == type) {
        return achievement.unlockedAt;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AchievementDefinitions.all.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final definition =
            AchievementDefinitions.all[index];

        return AchievementCard(
          definition: definition,
          unlocked: _isUnlocked(definition.type),
          unlockedAt: _unlockedAt(definition.type),
        );
      },
    );
  }
}
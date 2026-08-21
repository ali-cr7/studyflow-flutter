import 'package:study_planner/shared/data/database/collections/achievement_collection.dart';
import 'package:study_planner/shared/domain/entities/achievement.dart';

abstract final class AchievementMapper {
  static Achievement toDomain(AchievementCollection collection) {
    return Achievement(
      id: collection.id,
      type: collection.type,
      unlockedAt: collection.unlockedAt,
    );
  }

  static AchievementCollection toCollection(Achievement achievement) {
    final collection = AchievementCollection()
      ..type = achievement.type
      ..unlockedAt = achievement.unlockedAt;

    if (achievement.id != 0) {
      collection.id = achievement.id;
    }

    return collection;
  }
}

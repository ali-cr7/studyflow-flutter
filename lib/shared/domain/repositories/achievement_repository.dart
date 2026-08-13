import 'package:study_planner/shared/domain/entities/achievement.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';

/// Contract for gamification unlock records.
abstract class AchievementRepository {
  Future<List<Achievement>> getAll();

  Future<Achievement?> getByType(AchievementType type);

  Future<bool> hasUnlocked(AchievementType type);

  /// Creates the unlock if it does not already exist.
  Future<Achievement> unlock(AchievementType type);
}

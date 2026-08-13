import 'package:isar/isar.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';

part 'achievement_collection.g.dart';

/// A gamification badge or milestone the student has unlocked.
@collection
class AchievementCollection {
  Id id = Isar.autoIncrement;

  @Index()
  @Enumerated(EnumType.name)
  late AchievementType type;

  late DateTime unlockedAt;
}

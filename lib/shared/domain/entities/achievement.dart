import 'package:study_planner/shared/domain/enums/achievement_type.dart';

/// A badge or milestone the student has unlocked.
class Achievement {
  const Achievement({
    required this.id,
    required this.type,
    required this.unlockedAt,
  });

  final int id;
  final AchievementType type;
  final DateTime unlockedAt;

  Achievement copyWith({
    int? id,
    AchievementType? type,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id ?? this.id,
      type: type ?? this.type,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Achievement &&
        other.id == id &&
        other.type == type &&
        other.unlockedAt == unlockedAt;
  }

  @override
  int get hashCode => Object.hash(id, type, unlockedAt);
}

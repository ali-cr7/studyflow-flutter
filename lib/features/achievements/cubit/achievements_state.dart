part of 'achievements_cubit.dart';

@immutable


sealed class AchievementsState {
  const AchievementsState();
}

final class AchievementsInitial extends AchievementsState {
  const AchievementsInitial();
}

final class AchievementsLoading extends AchievementsState {
  const AchievementsLoading();
}

final class AchievementsLoaded extends AchievementsState {
  const AchievementsLoaded({
    required this.unlockedAchievements,
    required this.newlyUnlocked,
  });

  final List<Achievement> unlockedAchievements;

  /// Achievements unlocked during the latest check.
  final List<Achievement> newlyUnlocked;

  bool isUnlocked(AchievementType type) {
    return unlockedAchievements.any(
      (achievement) => achievement.type == type,
    );
  }
}

final class AchievementsError extends AchievementsState {
  const AchievementsError(this.message);

  final String message;
}
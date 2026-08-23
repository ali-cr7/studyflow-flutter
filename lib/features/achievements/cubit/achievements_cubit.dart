import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_planner/core/services/achievement_service.dart';
import 'package:study_planner/shared/domain/entities/achievement.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';

part 'achievements_state.dart';



class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsCubit({
    required AchievementService achievementService,
  })  : _achievementService = achievementService,
        super(const AchievementsInitial());

  final AchievementService _achievementService;

  Future<void> loadAchievements({
    bool checkForNew = true,
  }) async {
    emit(const AchievementsLoading());

    try {
      List<Achievement> newlyUnlocked = [];

      if (checkForNew) {
        newlyUnlocked =
            await _achievementService.checkAndUnlock();
      }

      final unlocked =
          await _achievementService.getUnlockedAchievements();

      emit(
        AchievementsLoaded(
          unlockedAchievements: unlocked,
          newlyUnlocked: newlyUnlocked,
        ),
      );
    } catch (error) {
      emit(
        AchievementsError(
          error.toString(),
        ),
      );
    }
  }

  Future<void> refresh() async {
    await loadAchievements(
      checkForNew: true,
    );
  }

  bool isUnlocked(AchievementType type) {
    final current = state;

    if (current is! AchievementsLoaded) {
      return false;
    }

    return current.isUnlocked(type);
  }

  void clearNewlyUnlocked() {
    final current = state;

    if (current is! AchievementsLoaded) {
      return;
    }

    emit(
      AchievementsLoaded(
        unlockedAchievements: current.unlockedAchievements,
        newlyUnlocked: const [],
      ),
    );
  }
}
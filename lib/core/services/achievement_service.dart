import 'package:study_planner/shared/domain/entities/achievement.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';
import 'package:study_planner/shared/domain/repositories/achievement_repository.dart';

import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';

class AchievementService {
  AchievementService({
    required AchievementRepository achievementRepository,
    required StudySessionRepository studySessionRepository,
    required AppSettingsRepository appSettingsRepository,
  })  : _achievementRepository = achievementRepository,
        _studySessionRepository = studySessionRepository,
        _appSettingsRepository = appSettingsRepository;

  final AchievementRepository _achievementRepository;
  final StudySessionRepository _studySessionRepository;
  final AppSettingsRepository _appSettingsRepository;

  Future<List<Achievement>> getUnlockedAchievements() {
    return _achievementRepository.getAll();
  }

  Future<List<Achievement>> checkAndUnlock() async {
    final sessions = await _studySessionRepository.getAll();

    final completedSessions = sessions
        .where((session) => session.completed)
        .toList();

    final unlocked = <Achievement>[];

    // ─────────────────────────────────────────────
    // First session
    // ─────────────────────────────────────────────

    if (completedSessions.isNotEmpty) {
      final achievement = await _unlockIfNeeded(
        AchievementType.firstSession,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    // ─────────────────────────────────────────────
    // Session count achievements
    // ─────────────────────────────────────────────

    final sessionCount = completedSessions.length;

    if (sessionCount >= 10) {
      final achievement = await _unlockIfNeeded(
        AchievementType.tenSessions,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    if (sessionCount >= 50) {
      final achievement = await _unlockIfNeeded(
        AchievementType.fiftySessions,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    if (sessionCount >= 100) {
      final achievement = await _unlockIfNeeded(
        AchievementType.hundredSessions,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    // ─────────────────────────────────────────────
    // Streak achievements
    // ─────────────────────────────────────────────

    final streak = _calculateCurrentStreak(completedSessions);

    if (streak >= 3) {
      final achievement = await _unlockIfNeeded(
        AchievementType.streak3,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    if (streak >= 7) {
      final achievement = await _unlockIfNeeded(
        AchievementType.streak7,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    if (streak >= 30) {
      final achievement = await _unlockIfNeeded(
        AchievementType.streak30,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    // ─────────────────────────────────────────────
    // Daily goal
    // ─────────────────────────────────────────────

    final settings = await _appSettingsRepository.getSettings();

    final goalMinutes = settings.studyDuration;

    final today = DateTime.now();

    final todayMinutes = completedSessions
        .where(
          (session) => _isSameDay(
            session.startTime,
            today,
          ),
        )
        .fold<int>(
          0,
          (sum, session) => sum + (session.duration ~/ 60),
        );

    if (todayMinutes >= goalMinutes) {
      final achievement = await _unlockIfNeeded(
        AchievementType.dailyGoalMet,
      );

      if (achievement != null) {
        unlocked.add(achievement);
      }
    }

    return unlocked;
  }

  Future<Achievement?> _unlockIfNeeded(
    AchievementType type,
  ) async {
    final alreadyUnlocked =
        await _achievementRepository.hasUnlocked(type);

    if (alreadyUnlocked) {
      return null;
    }

    return _achievementRepository.unlock(type);
  }

  int _calculateCurrentStreak(
    List<StudySession> sessions,
  ) {
    if (sessions.isEmpty) {
      return 0;
    }

    final studyDays = sessions
        .map(
          (session) => DateTime(
            session.startTime.year,
            session.startTime.month,
            session.startTime.day,
          ),
        )
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final today = DateTime.now();

    final normalizedToday = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final yesterday = normalizedToday.subtract(
      const Duration(days: 1),
    );

    if (studyDays.first != normalizedToday &&
        studyDays.first != yesterday) {
      return 0;
    }

    var streak = 1;

    for (var i = 1; i < studyDays.length; i++) {
      final difference =
          studyDays[i - 1].difference(studyDays[i]).inDays;

      if (difference != 1) {
        break;
      }

      streak++;
    }

    return streak;
  }

  bool _isSameDay(
    DateTime first,
    DateTime second,
  ) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}
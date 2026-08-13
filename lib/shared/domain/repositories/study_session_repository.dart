import 'package:study_planner/shared/domain/entities/study_session.dart';

/// Contract for persisted study / Pomodoro sessions.
abstract class StudySessionRepository {
  Future<List<StudySession>> getAll();

  Future<StudySession?> getById(int id);

  Future<List<StudySession>> getBySubject(int subjectId);

  Future<List<StudySession>> getByDateRange({
    required DateTime start,
    required DateTime end,
  });

  /// The session that was interrupted by an app restart, if any.
  Future<StudySession?> getActiveSession();

  Future<StudySession> save(StudySession session);

  Future<void> delete(int id);
}

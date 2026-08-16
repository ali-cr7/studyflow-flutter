import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/features/session/cubit/session_cubit.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';

void main() {
  group('SessionCubit', () {
    test('starts an active study session for the selected subject', () async {
      final repository = _FakeStudySessionRepository();
      final cubit = SessionCubit(
        sessionRepository: repository,
        subject: const Subject(
          id: 9,
          name: 'Math',
          color: 0xFF4C6FFF,
          icon: 'calculate',
        ),
        plannedMinutes: 25,
      );

      await cubit.startSession();

      expect(cubit.state, isA<SessionActive>());
      final state = cubit.state as SessionActive;
      expect(state.session.subjectId, 9);
      expect(state.session.completed, isFalse);
      expect(state.totalSeconds, 1500);
      expect(state.remainingSeconds, 1500);
      expect(repository.savedSessions.length, 1);
    });

    test('finishes a running session as completed', () async {
      final repository = _FakeStudySessionRepository();
      final cubit = SessionCubit(
        sessionRepository: repository,
        subject: const Subject(
          id: 9,
          name: 'Math',
          color: 0xFF4C6FFF,
          icon: 'calculate',
        ),
        plannedMinutes: 25,
      );

      await cubit.startSession();
      await cubit.finishSession();

      expect(cubit.state, isA<SessionBreakActive>());
      final state = cubit.state as SessionBreakActive;
      expect(state.remainingSeconds, state.totalSeconds);
      expect(repository.savedSessions.first.completed, isTrue);
    });

    test(
      'pauses and resumes a session when the user stops or starts it',
      () async {
        final repository = _FakeStudySessionRepository();
        final cubit = SessionCubit(
          sessionRepository: repository,
          subject: const Subject(
            id: 9,
            name: 'Math',
            color: 0xFF4C6FFF,
            icon: 'calculate',
          ),
          plannedMinutes: 25,
        );

        await cubit.startSession();
        await cubit.pauseSession();

        expect(cubit.state, isA<SessionPaused>());
        expect(repository.savedSessions.first.duration, 0);

        await cubit.resumeSession();
        expect(cubit.state, isA<SessionActive>());
      },
    );

    test(
      'lets the user continue to the next session after the break ends',
      () async {
        final repository = _FakeStudySessionRepository();
        final cubit = SessionCubit(
          sessionRepository: repository,
          subject: const Subject(
            id: 9,
            name: 'Math',
            color: 0xFF4C6FFF,
            icon: 'calculate',
          ),
          plannedMinutes: 25,
          breakDurationMinutes: 1,
        );

        await cubit.startSession();
        await cubit.finishSession();
        await cubit.completeBreak();

        expect(cubit.state, isA<SessionBreakComplete>());
      },
    );
  });
}

class _FakeStudySessionRepository implements StudySessionRepository {
  final List<StudySession> savedSessions = [];

  @override
  Future<List<StudySession>> getAll() async => List.unmodifiable(savedSessions);

  @override
  Future<StudySession?> getById(int id) async {
    for (final session in savedSessions) {
      if (session.id == id) return session;
    }
    return null;
  }

  @override
  Future<List<StudySession>> getBySubject(int subjectId) async => savedSessions
      .where((session) => session.subjectId == subjectId)
      .toList(growable: false);

  @override
  Future<List<StudySession>> getByDateRange({
    required DateTime start,
    required DateTime end,
  }) async => savedSessions
      .where(
        (session) =>
            !session.startTime.isBefore(start) &&
            session.startTime.isBefore(end),
      )
      .toList(growable: false);

  @override
  Future<StudySession?> getActiveSession() async {
    for (final session in savedSessions) {
      if (!session.completed && session.endTime == null) return session;
    }
    return null;
  }

  @override
  Future<StudySession> save(StudySession session) async {
    if (session.id == 0) {
      final created = session.copyWith(id: savedSessions.length + 1);
      savedSessions.add(created);
      return created;
    }

    final index = savedSessions.indexWhere((item) => item.id == session.id);
    if (index >= 0) {
      savedSessions[index] = session;
      return session;
    }

    savedSessions.add(session);
    return session;
  }

  @override
  Future<void> delete(int id) async {
    savedSessions.removeWhere((session) => session.id == id);
  }
}

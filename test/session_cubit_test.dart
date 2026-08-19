import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/core/services/study_timer_background_service.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/features/session/cubit/session_cubit.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/active_timer_repository.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

void main() {
  group('SessionCubit', () {
    test('starts an active study session for the selected subject', () async {
      final repository = _FakeStudySessionRepository();
      final subject = _mathSubject;
      final cubit = SessionCubit(
        timerService: _timerService(repository, subject),
        subject: subject,
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
      final subject = _mathSubject;
      final cubit = SessionCubit(
        timerService: _timerService(repository, subject),
        subject: subject,
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
        final subject = _mathSubject;
        final cubit = SessionCubit(
          timerService: _timerService(repository, subject),
          subject: subject,
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
        final subject = _mathSubject;
        final cubit = SessionCubit(
          timerService: _timerService(repository, subject),
          subject: subject,
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

const _mathSubject = Subject(
  id: 9,
  name: 'Math',
  color: 0xFF4C6FFF,
  icon: 'calculate',
);

StudyTimerService _timerService(
  _FakeStudySessionRepository sessionRepository,
  Subject subject,
) {
  return StudyTimerService(
    activeTimerRepository: _FakeActiveTimerRepository(),
    sessionRepository: sessionRepository,
    dailyPlanRepository: _FakeDailyPlanRepository(),
    settingsRepository: _FakeAppSettingsRepository(),
    subjectRepository: _FakeSubjectRepository(subject),
    notificationService: _FakeNotificationService(),
    backgroundService: _FakeBackgroundService(),
  );
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

class _FakeActiveTimerRepository implements ActiveTimerRepository {
  ActiveTimerState? state;

  @override
  Future<void> clear() async {
    state = null;
  }

  @override
  Future<ActiveTimerState?> getActiveTimer() async => state;

  @override
  Future<ActiveTimerState> save(ActiveTimerState state) async {
    this.state = state;
    return state;
  }
}

class _FakeDailyPlanRepository implements DailyPlanRepository {
  @override
  Future<void> deletePlannedSubject(int plannedSubjectId) async {}

  @override
  Future<DailyPlan?> getByDate(DateTime date) async => null;

  @override
  Future<DailyPlan> getOrCreateForDate(DateTime date) async =>
      DailyPlan(id: 1, date: date, subjects: const []);

  @override
  Future<void> reorderPlannedSubjects(List<int> orderedPlannedSubjectIds) async {}

  @override
  Future<void> save(DailyPlan plan) async {}

  @override
  Future<void> updatePlannedSubject(PlannedSubject plannedSubject) async {}
}

class _FakeAppSettingsRepository implements AppSettingsRepository {
  AppSettings settings = AppSettings.defaults();

  @override
  Future<AppSettings> getSettings() async => settings;

  @override
  Future<void> saveSettings(AppSettings settings) async {
    this.settings = settings;
  }
}

class _FakeSubjectRepository implements SubjectRepository {
  _FakeSubjectRepository(this.subject);

  final Subject subject;

  @override
  Future<void> delete(int id) async {}

  @override
  Future<List<Subject>> getAll() async => [subject];

  @override
  Future<Subject?> getById(int id) async => id == subject.id ? subject : null;

  @override
  Future<Subject> save(Subject subject) async => subject;
}

class _FakeNotificationService extends TimerNotificationService {
  @override
  Future<void> cancelForeground() async {}

  @override
  Future<void> cancelTimerSchedules() async {}

  @override
  Future<void> initialize() async {}

  @override
  Future<void> requestPermissions() async {}

  @override
  Future<void> scheduleBreakCompleted({
    required DateTime endsAt,
    required Subject subject,
  }) async {}

  @override
  Future<void> scheduleStudyCompleted({
    required DateTime endsAt,
    required Subject subject,
  }) async {}

  @override
  Future<void> showBreakComplete() async {}

  @override
  Future<void> showBreakStarted() async {}

  @override
  Future<void> showForegroundTimer({
    required String title,
    required String body,
  }) async {}

  @override
  Future<void> showStudyComplete() async {}
}

class _FakeBackgroundService extends StudyTimerBackgroundService {
  @override
  Future<void> configure() async {}

  @override
  Future<void> start() async {}

  @override
  Future<void> stop() async {}
}

import 'package:flutter/foundation.dart';
import 'package:study_planner/core/services/study_timer_background_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/core/utils/date_utils.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/active_timer_repository.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class StudyTimerSnapshot {
  const StudyTimerSnapshot({
    required this.timer,
    required this.subject,
    required this.remainingSeconds,
    required this.elapsedSeconds,
    this.session,
  });

  final ActiveTimerState? timer;
  final Subject subject;
  final StudySession? session;
  final int remainingSeconds;
  final int elapsedSeconds;
}

class StudyTimerService {
  StudyTimerService({
    required ActiveTimerRepository activeTimerRepository,
    required StudySessionRepository sessionRepository,
    required DailyPlanRepository dailyPlanRepository,
    required AppSettingsRepository settingsRepository,
    required SubjectRepository subjectRepository,
    required TimerNotificationService notificationService,
    StudyTimerBackgroundService? backgroundService,
  }) : _activeTimerRepository = activeTimerRepository,
       _sessionRepository = sessionRepository,
       _dailyPlanRepository = dailyPlanRepository,
       _settingsRepository = settingsRepository,
       _subjectRepository = subjectRepository,
       _notificationService = notificationService,
       _backgroundService = backgroundService;

  final ActiveTimerRepository _activeTimerRepository;
  final StudySessionRepository _sessionRepository;
  final DailyPlanRepository _dailyPlanRepository;
  final AppSettingsRepository _settingsRepository;
  final SubjectRepository _subjectRepository;
  final TimerNotificationService _notificationService;
  final StudyTimerBackgroundService? _backgroundService;

  Future<StudyTimerSnapshot?> restoreForSubject(Subject subject) async {
    await reconcile(subject: subject);
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null || timer.subjectId != subject.id) return null;
    return _snapshot(timer, subject);
  }

  Future<StudyTimerSnapshot> startStudy({
    required Subject subject,
    required int plannedDurationSeconds,
  }) async {
    final existing = await restoreForSubject(subject);
    if (existing?.timer != null) return existing!;

    final now = DateTime.now();
    final session = await _sessionRepository.save(
      StudySession(
        id: 0,
        subjectId: subject.id,
        startTime: now,
        endTime: null,
        duration: 0,
        completed: false,
      ),
    );
    final timer = await _activeTimerRepository.save(
      ActiveTimerState(
        id: ActiveTimerState.singletonId,
        phase: ActiveTimerPhase.study,
        subjectId: subject.id,
        sessionId: session.id,
        startedAt: now,
        endsAt: now.add(Duration(seconds: plannedDurationSeconds)),
        accumulatedSeconds: 0,
        plannedDurationSeconds: plannedDurationSeconds,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await _scheduleFor(timer, subject);
    await _backgroundService?.start();
    return _snapshot(timer, subject, session: session);
  }

  Future<StudyTimerSnapshot?> pause(Subject subject) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null ||
        timer.subjectId != subject.id ||
        timer.phase != ActiveTimerPhase.study) {
      return null;
    }

    final now = DateTime.now();
    final elapsed = timer.elapsedSeconds(now);
    final paused = await _activeTimerRepository.save(
      timer.copyWith(
        phase: ActiveTimerPhase.paused,
        accumulatedSeconds: elapsed,
        updatedAt: now,
        clearStartedAt: true,
        clearEndsAt: true,
      ),
    );
    await _persistProgress(paused, completed: false);
    await _notificationService.cancelTimerSchedules();
    await _backgroundService?.stop();
    return _snapshot(paused, subject);
  }

  Future<StudyTimerSnapshot?> resume(Subject subject) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null ||
        timer.subjectId != subject.id ||
        timer.phase != ActiveTimerPhase.paused) {
      return null;
    }

    final now = DateTime.now();
    final remaining = timer.remainingSeconds(now);
    final running = await _activeTimerRepository.save(
      timer.copyWith(
        phase: ActiveTimerPhase.study,
        startedAt: now,
        endsAt: now.add(Duration(seconds: remaining)),
        updatedAt: now,
      ),
    );
    await _scheduleFor(running, subject);
    await _backgroundService?.start();
    return _snapshot(running, subject);
  }

  Future<StudyTimerSnapshot?> finishStudy(Subject subject) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null || timer.subjectId != subject.id) return null;
    if (timer.phase != ActiveTimerPhase.study &&
        timer.phase != ActiveTimerPhase.paused) {
      return null;
    }

    await _completeStudy(timer, subject, manual: true);
    final next = await _activeTimerRepository.getActiveTimer();
    return next == null ? null : _snapshot(next, subject);
  }

  Future<void> cancel(Subject subject) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer?.subjectId != subject.id) return;

    final sessionId = timer?.sessionId;
    if (sessionId != null) {
      final session = await _sessionRepository.getById(sessionId);
      if (session != null && !session.completed) {
        await _sessionRepository.save(
          session.copyWith(endTime: DateTime.now(), completed: false),
        );
      }
    }

    await _activeTimerRepository.clear();
    await _notificationService.cancelTimerSchedules();
    await _backgroundService?.stop();
  }

  Future<StudyTimerSnapshot?> completeBreak(Subject subject) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null ||
        timer.subjectId != subject.id ||
        timer.phase != ActiveTimerPhase.breakTime) {
      return null;
    }

    await _activeTimerRepository.clear();
    await _notificationService.cancelTimerSchedules();
    await _notificationService.showBreakComplete();
    await _backgroundService?.stop();
    return null;
  }

  Future<StudyTimerSnapshot?> reconcile({Subject? subject}) async {
    final timer = await _activeTimerRepository.getActiveTimer();
    if (timer == null || !timer.isRunning) return null;
    subject ??= await _subjectRepository.getById(timer.subjectId);
    if (subject == null) return null;

    final now = DateTime.now();
    if (!timer.isExpired(now)) {
      if (subject != null) return _snapshot(timer, subject);
      return null;
    }

    if (timer.phase == ActiveTimerPhase.study) {
      await _completeStudy(timer, subject, manual: false);
      final next = await _activeTimerRepository.getActiveTimer();
      return next == null ? null : _snapshot(next, subject);
    }

    if (timer.phase == ActiveTimerPhase.breakTime) {
      await _activeTimerRepository.clear();
      await _notificationService.cancelTimerSchedules();
      await _notificationService.showBreakComplete();
      await _backgroundService?.stop();
    }

    return null;
  }

  Future<void> _completeStudy(
    ActiveTimerState timer,
    Subject subject, {
    required bool manual,
  }) async {
    final now = DateTime.now();
    final session = timer.sessionId == null
        ? null
        : await _sessionRepository.getById(timer.sessionId!);

    if (session != null && !session.completed) {
      final duration = manual
          ? timer.elapsedSeconds(now)
          : timer.plannedDurationSeconds;
      await _sessionRepository.save(
        session.copyWith(
          endTime: manual ? now : timer.endsAt ?? now,
          duration: duration,
          completed: true,
        ),
      );
      await _markDailyPlanSubjectComplete(subject.id);
    }

    await _notificationService.cancelTimerSchedules();
    await _notificationService.showStudyComplete();

    final settings = await _settingsRepository.getSettings();
    final breakSeconds = (settings.breakDuration * 60)
        .clamp(1, 24 * 60 * 60)
        .toInt();
    final breakStart = manual ? now : timer.endsAt ?? now;
    final breakTimer = await _activeTimerRepository.save(
      ActiveTimerState(
        id: ActiveTimerState.singletonId,
        phase: ActiveTimerPhase.breakTime,
        subjectId: subject.id,
        startedAt: breakStart,
        endsAt: breakStart.add(Duration(seconds: breakSeconds)),
        accumulatedSeconds: 0,
        plannedDurationSeconds: breakSeconds,
        createdAt: timer.createdAt,
        updatedAt: now,
      ),
    );
    await _notificationService.showBreakStarted();
    await _scheduleFor(breakTimer, subject);
    await _backgroundService?.start();
  }

  Future<void> _persistProgress(
    ActiveTimerState timer, {
    required bool completed,
  }) async {
    final sessionId = timer.sessionId;
    if (sessionId == null) return;
    final session = await _sessionRepository.getById(sessionId);
    if (session == null || session.completed) return;
    await _sessionRepository.save(
      session.copyWith(
        duration: timer.accumulatedSeconds,
        completed: completed,
        endTime: completed ? DateTime.now() : null,
      ),
    );
  }

  Future<void> _markDailyPlanSubjectComplete(int subjectId) async {
    try {
      final today = await _dailyPlanRepository.getByDate(
        normalizeToLocalDate(DateTime.now()),
      );
      if (today == null) return;
      for (final planned in today.subjects) {
        if (planned.subjectId == subjectId && !planned.completed) {
          await _dailyPlanRepository.updatePlannedSubject(
            planned.copyWith(completed: true),
          );
          return;
        }
      }
    } catch (error, stackTrace) {
      debugPrint('Daily plan completion update failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _scheduleFor(ActiveTimerState timer, Subject subject) async {
    if (timer.endsAt == null) return;
    try {
      final settings = await _settingsRepository.getSettings();
      if (!settings.notificationsEnabled) return;
      if (timer.phase == ActiveTimerPhase.study) {
        await _notificationService.scheduleStudyCompleted(
          endsAt: timer.endsAt!,
          subject: subject,
        );
      } else if (timer.phase == ActiveTimerPhase.breakTime) {
        await _notificationService.scheduleBreakCompleted(
          endsAt: timer.endsAt!,
          subject: subject,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Timer notification scheduling failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<StudyTimerSnapshot> _snapshot(
    ActiveTimerState timer,
    Subject subject, {
    StudySession? session,
  }) async {
    final now = DateTime.now();
    final persistedSession = session ??
        (timer.sessionId == null
            ? null
            : await _sessionRepository.getById(timer.sessionId!));
    return StudyTimerSnapshot(
      timer: timer,
      subject: subject,
      session: persistedSession,
      remainingSeconds: timer.remainingSeconds(now),
      elapsedSeconds: timer.elapsedSeconds(now),
    );
  }
}

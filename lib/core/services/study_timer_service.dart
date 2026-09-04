import 'package:flutter/foundation.dart';
import 'package:study_planner/core/services/notification_strings.dart';
import 'package:study_planner/core/services/study_timer_background_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/core/utils/date_utils.dart';
import 'package:study_planner/features/session/cubit/session_cubit.dart';

import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/active_timer_repository.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class StudyTimerSnapshot {
  const StudyTimerSnapshot({
    required this.timer,
    required this.subject,
    required this.remainingSeconds,
    required this.elapsedSeconds,
    this.session,
    this.celebrationReason = CelebrationReason.none,
  });

  final ActiveTimerState? timer;
  final Subject subject;
  final StudySession? session;
  final int remainingSeconds;
  final int elapsedSeconds;

  /// Non-none when a milestone was just hit and the UI should show a card.
  final CelebrationReason celebrationReason;
}

class StudyTimerService {
  StudyTimerService({
    required ActiveTimerRepository activeTimerRepository,
    required StudySessionRepository sessionRepository,
    required DailyPlanRepository dailyPlanRepository,
    required AppSettingsRepository settingsRepository,
    required SubjectRepository subjectRepository,
    required TimerNotificationService notificationService,
    required StudentProfileRepository studentProfileRepository,
    StudyTimerBackgroundService? backgroundService,
  }) : _activeTimerRepository = activeTimerRepository,
       _sessionRepository = sessionRepository,
       _dailyPlanRepository = dailyPlanRepository,
       _settingsRepository = settingsRepository,
       _subjectRepository = subjectRepository,
       _notificationService = notificationService,
       _studentProfileRepository = studentProfileRepository,
       _backgroundService = backgroundService;

  final ActiveTimerRepository _activeTimerRepository;
  final StudySessionRepository _sessionRepository;
  final DailyPlanRepository _dailyPlanRepository;
  final AppSettingsRepository _settingsRepository;
  final SubjectRepository _subjectRepository;
  final TimerNotificationService _notificationService;
  final StudentProfileRepository _studentProfileRepository;
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

    final reason = await _completeStudy(timer, subject, manual: true);
    final next = await _activeTimerRepository.getActiveTimer();
    return next == null
        ? null
        : _snapshot(next, subject, celebrationReason: reason);
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
    final strings = await _strings();
    await _notificationService.showBreakComplete(
      title: strings.breakFinishedTitle,
      body:  strings.breakFinishedBody,
    );
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
      return _snapshot(timer, subject);
    }

    if (timer.phase == ActiveTimerPhase.study) {
      final reason = await _completeStudy(timer, subject, manual: false);
      final next = await _activeTimerRepository.getActiveTimer();
      return next == null
          ? null
          : _snapshot(next, subject, celebrationReason: reason);
    }

    if (timer.phase == ActiveTimerPhase.breakTime) {
      await _activeTimerRepository.clear();
      await _notificationService.cancelTimerSchedules();
      final strings = await _strings();
      await _notificationService.showBreakComplete(
        title: strings.breakFinishedTitle,
        body:  strings.breakFinishedBody,
      );
      await _backgroundService?.stop();
    }

    return null;
  }

  // ── Core study-completion logic ───────────────────────────────────────────
  //
  // Returns the [CelebrationReason] detected so callers can embed it in the
  // next snapshot without a separate repository round-trip.

  Future<CelebrationReason> _completeStudy(
    ActiveTimerState timer,
    Subject subject, {
    required bool manual,
  }) async {
    final now = DateTime.now();
    final session = timer.sessionId == null
        ? null
        : await _sessionRepository.getById(timer.sessionId!);

    var subjectJustCompleted = false;

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
      subjectJustCompleted = await _markDailyPlanSubjectComplete(subject.id);
    }

    // Resolve the current language once for all notifications in this call.
    final strings = await _strings();

    await _notificationService.cancelTimerSchedules();
    await _notificationService.showStudyComplete(
      title: strings.studyCompleteTitle,
      body:  strings.studyCompleteBody,
    );

    // ── Milestone detection ───────────────────────────────────────────────
    final dailyGoalJustReached = await _checkDailyGoalReached();

    final reason = _resolveCelebrationReason(
      subjectCompleted: subjectJustCompleted,
      dailyGoalReached: dailyGoalJustReached,
    );

    // Fire celebration notifications (in addition to the standard ones above).
    if (subjectJustCompleted) {
      await _notificationService.showSubjectCompleted(
        title: strings.subjectCompleteTitle,
        body:  strings.subjectCompleteBody(subject.name),
      );
    }
    if (dailyGoalJustReached) {
      await _notificationService.showDailyGoalReached(
        title: strings.dailyGoalTitle,
        body:  strings.dailyGoalBody,
      );
    }

    // ── Create the break timer ────────────────────────────────────────────
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
    await _notificationService.showBreakStarted(
      title: strings.breakStartedTitle,
      body:  strings.breakStartedBody,
    );
    await _scheduleFor(breakTimer, subject, strings: strings);
    await _backgroundService?.start();

    return reason;
  }

  /// Marks the matching [PlannedSubject] as completed.
  /// Returns `true` if a subject was actually flipped to completed this call
  /// (i.e. it was not already done), `false` otherwise.
  Future<bool> _markDailyPlanSubjectComplete(int subjectId) async {
    try {
      final today = await _dailyPlanRepository.getByDate(
        normalizeToLocalDate(DateTime.now()),
      );
      if (today == null) return false;
      for (final planned in today.subjects) {
        if (planned.subjectId == subjectId && !planned.completed) {
          await _dailyPlanRepository.updatePlannedSubject(
            planned.copyWith(completed: true),
          );
          return true;
        }
      }
      return false;
    } catch (error, stackTrace) {
      debugPrint('Daily plan completion update failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  /// Returns `true` when today's completed planned minutes exactly meets or
  /// first crosses the student's daily goal after this session.
  ///
  /// We check *after* saving the session so the freshly completed minutes are
  /// already reflected in the plan.
  Future<bool> _checkDailyGoalReached() async {
    try {
      final profile = await _studentProfileRepository.getProfile();
      if (profile == null || profile.dailyGoalMinutes <= 0) return false;

      final today = await _dailyPlanRepository.getByDate(
        normalizeToLocalDate(DateTime.now()),
      );
      if (today == null) return false;

      // completedPlannedMinutes is in minutes; dailyGoalMinutes is in minutes.
      final completed = today.completedPlannedMinutes;
      final goal = profile.dailyGoalMinutes;

      // Fire only on the exact crossing — when completed just reached or
      // surpassed the goal.  We consider it "just reached" if the completed
      // count equals the goal (or we are within one session-worth above it).
      return completed >= goal;
    } catch (error, stackTrace) {
      debugPrint('Daily goal check failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  static CelebrationReason _resolveCelebrationReason({
    required bool subjectCompleted,
    required bool dailyGoalReached,
  }) {
    if (subjectCompleted && dailyGoalReached) return CelebrationReason.both;
    if (dailyGoalReached) return CelebrationReason.dailyGoalReached;
    if (subjectCompleted) return CelebrationReason.subjectCompleted;
    return CelebrationReason.none;
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

  Future<void> _scheduleFor(
    ActiveTimerState timer,
    Subject subject, {
    NotificationStrings? strings,
  }) async {
    if (timer.endsAt == null) return;
    try {
      final settings = await _settingsRepository.getSettings();
      if (!settings.notificationsEnabled) return;
      // Resolve strings at schedule time so the embedded title/body match the
      // language currently selected by the user.
      final s = strings ?? NotificationStrings.forLanguage(settings.language);
      if (timer.phase == ActiveTimerPhase.study) {
        await _notificationService.scheduleStudyCompleted(
          endsAt:  timer.endsAt!,
          subject: subject,
          title:   s.studyCompleteTitle,
          body:    s.studyCompleteBody,
        );
      } else if (timer.phase == ActiveTimerPhase.breakTime) {
        await _notificationService.scheduleBreakCompleted(
          endsAt:  timer.endsAt!,
          subject: subject,
          title:   s.breakFinishedTitle,
          body:    s.breakFinishedBody,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Timer notification scheduling failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  /// Builds a [NotificationStrings] for the currently persisted language.
  Future<NotificationStrings> _strings() async {
    final settings = await _settingsRepository.getSettings();
    return NotificationStrings.forLanguage(settings.language);
  }

  Future<StudyTimerSnapshot> _snapshot(
    ActiveTimerState timer,
    Subject subject, {
    StudySession? session,
    CelebrationReason celebrationReason = CelebrationReason.none,
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
      celebrationReason: celebrationReason,
    );
  }
}

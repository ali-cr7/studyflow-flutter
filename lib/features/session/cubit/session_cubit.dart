import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required StudyTimerService timerService,
    required Subject subject,
    required int plannedMinutes,
    int breakDurationMinutes = 5,
    AppSettingsRepository? settingsRepository,
  }) : _timerService = timerService,
       _subject = subject,
       _plannedMinutes = plannedMinutes,
       _settingsRepository = settingsRepository,
       _breakDurationMinutes = breakDurationMinutes,
       super(SessionInitial());

  final StudyTimerService _timerService;
  final Subject _subject;
  final int _plannedMinutes;
  final AppSettingsRepository? _settingsRepository;
  int _breakDurationMinutes;

  Timer? _timer;

  int get totalSeconds => _plannedMinutes * 60;
  int get breakTotalSeconds => _breakDurationMinutes * 60;

  Future<void> loadBreakDuration() async {
    final settings = await _settingsRepository?.getSettings();
    if (settings != null && settings.breakDuration > 0) {
      _breakDurationMinutes = settings.breakDuration;
    }
  }

  Future<void> restoreOrStartSession() async {
    try {
      await loadBreakDuration();
      final restored = await _timerService.restoreForSubject(_subject);
      if (restored != null) {
        _emitSnapshot(restored);
        _startProjectionTicker();
        return;
      }
      await startSession();
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> saveCurrentProgress() async {
    if (isClosed) return;
    final current = state;
    if (current is SessionActive) {
      final snapshot = await _timerService.restoreForSubject(_subject);
      if (!isClosed && snapshot != null) _emitSnapshot(snapshot);
    }
  }

  Future<void> startSession() async {
    if (state is SessionActive ||
        state is SessionPaused ||
        state is SessionBreakActive ||
        state is SessionBreakComplete) {
      return;
    }

    try {
      await loadBreakDuration();
      final snapshot = await _timerService.startStudy(
        subject: _subject,
        plannedDurationSeconds: totalSeconds,
      );
      _emitSnapshot(snapshot);
      _startProjectionTicker();
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> pauseSession() async {
    try {
      final snapshot = await _timerService.pause(_subject);
      if (snapshot == null) return;
      _timer?.cancel();
      _timer = null;
      _emitSnapshot(snapshot);
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> resumeSession() async {
    try {
      final snapshot = await _timerService.resume(_subject);
      if (snapshot == null) return;
      _emitSnapshot(snapshot);
      _startProjectionTicker();
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> finishSession() async {
    try {
      final snapshot = await _timerService.finishStudy(_subject);
      if (snapshot == null) return;
      _emitSnapshot(snapshot);
      _startProjectionTicker();
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> completeBreak() async {
    try {
      await _timerService.completeBreak(_subject);
      _timer?.cancel();
      _timer = null;
      _emitState(
        SessionBreakComplete(
          subject: _subject,
          totalSeconds: breakTotalSeconds,
        ),
      );
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  Future<void> cancelSession() async {
    try {
      await _timerService.cancel(_subject);
      _timer?.cancel();
      _timer = null;
      _emitState(SessionError('Session cancelled'));
    } catch (error) {
      _emitState(SessionError(error.toString()));
    }
  }

  void _startProjectionTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        final snapshot =
            await _timerService.reconcile(subject: _subject) ??
            await _timerService.restoreForSubject(_subject);
        if (snapshot == null) {
          _timer?.cancel();
          _timer = null;
          _emitState(
            SessionBreakComplete(
              subject: _subject,
              totalSeconds: breakTotalSeconds,
            ),
          );
          return;
        }
        _emitSnapshot(snapshot);
        if (snapshot.timer?.phase == ActiveTimerPhase.paused) {
          _timer?.cancel();
          _timer = null;
        }
      } catch (error) {
        _emitState(SessionError(error.toString()));
      }
    });
  }

  void _emitSnapshot(StudyTimerSnapshot snapshot) {
    if (isClosed) return;
    final timer = snapshot.timer;
    if (timer == null) {
      _emitState(
        SessionBreakComplete(
          subject: _subject,
          totalSeconds: breakTotalSeconds,
        ),
      );
      return;
    }

    switch (timer.phase) {
      case ActiveTimerPhase.study:
        final session =
            snapshot.session ??
            StudySession(
              id: timer.sessionId ?? 0,
              subjectId: _subject.id,
              startTime: timer.startedAt ?? DateTime.now(),
              endTime: null,
              duration: snapshot.elapsedSeconds,
              completed: false,
            );
        _emitState(
          SessionActive(
            session: session.copyWith(duration: snapshot.elapsedSeconds),
            subject: _subject,
            totalSeconds: timer.plannedDurationSeconds,
            remainingSeconds: snapshot.remainingSeconds,
          ),
        );
      case ActiveTimerPhase.paused:
        final session =
            snapshot.session ??
            StudySession(
              id: timer.sessionId ?? 0,
              subjectId: _subject.id,
              startTime: DateTime.now(),
              endTime: null,
              duration: snapshot.elapsedSeconds,
              completed: false,
            );
        _emitState(
          SessionPaused(
            session: session.copyWith(duration: snapshot.elapsedSeconds),
            subject: _subject,
            totalSeconds: timer.plannedDurationSeconds,
            remainingSeconds: snapshot.remainingSeconds,
          ),
        );
      case ActiveTimerPhase.breakTime:
        _emitState(
          SessionBreakActive(
            subject: _subject,
            totalSeconds: timer.plannedDurationSeconds,
            remainingSeconds: snapshot.remainingSeconds,
          ),
        );
      case ActiveTimerPhase.idle:
        _emitState(
          SessionBreakComplete(
            subject: _subject,
            totalSeconds: breakTotalSeconds,
          ),
        );
    }
  }

  void _emitState(SessionState nextState) {
    if (!isClosed) emit(nextState);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

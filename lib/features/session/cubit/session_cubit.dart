import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/data/repositories/mappers/study_session_mapper.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required StudySessionRepository sessionRepository,
    required Subject subject,
    required int plannedMinutes,
    int breakDurationMinutes = 5,
    AppSettingsRepository? settingsRepository,
  }) : _sessionRepository = sessionRepository,
       _subject = subject,
       _plannedMinutes = plannedMinutes,
       _settingsRepository = settingsRepository,
       _breakDurationMinutes = breakDurationMinutes,
       super(SessionInitial());

  final StudySessionRepository _sessionRepository;
  //final StudySessionMapper _mapper = StudySessionMapper();
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
    await loadBreakDuration();

    final active = await _sessionRepository.getActiveSession();
    if (active != null && active.subjectId == _subject.id) {
      final elapsedSeconds = _elapsedSeconds(active.startTime, DateTime.now());
      final remainingSeconds = (totalSeconds - elapsedSeconds).clamp(
        0,
        totalSeconds,
      );

      if (remainingSeconds <= 0) {
        final completedSession = active.copyWith(
          endTime: DateTime.now(),
          duration: totalSeconds,
          completed: true,
        );
        await _sessionRepository.save(completedSession);
        _startBreakTicker();
        emit(
          SessionBreakActive(
            subject: _subject,
            totalSeconds: breakTotalSeconds,
            remainingSeconds: breakTotalSeconds,
          ),
        );
        return;
      }

      final restored = active.copyWith(
        duration: totalSeconds - remainingSeconds,
      );
      await _sessionRepository.save(restored);
      _startSessionTicker(restored);
      emit(
        SessionActive(
          session: restored,
          subject: _subject,
          totalSeconds: totalSeconds,
          remainingSeconds: remainingSeconds,
        ),
      );
      return;
    }

    await startSession();
  }

  Future<void> saveCurrentProgress() async {
    final current = state;

    if (current is SessionActive) {
      final elapsedSeconds = _elapsedSeconds(
        current.session.startTime,
        DateTime.now(),
      );
      final duration = elapsedSeconds.clamp(0, totalSeconds);
      final updated = current.session.copyWith(
        duration: duration,
        endTime: duration >= totalSeconds ? DateTime.now() : null,
        completed: duration >= totalSeconds,
      );
      await _sessionRepository.save(updated);
    } else if (current is SessionPaused) {
      final duration = (totalSeconds - current.remainingSeconds).clamp(
        0,
        totalSeconds,
      );
      final updated = current.session.copyWith(duration: duration);
      await _sessionRepository.save(updated);
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
      final now = DateTime.now();
      final session = StudySession(
        id: 0,
        subjectId: _subject.id,
        startTime: now,
        endTime: null,
        duration: 0,
        completed: false,
      );

      final saved = await _sessionRepository.save(session);
      _startSessionTicker(saved);
      emit(
        SessionActive(
          session: saved,
          subject: _subject,
          totalSeconds: totalSeconds,
          remainingSeconds: totalSeconds,
        ),
      );
    } catch (error) {
      emit(SessionError(error.toString()));
    }
  }

  Future<void> pauseSession() async {
    final current = state;
    if (current is! SessionActive) return;

    final duration = (totalSeconds - current.remainingSeconds).clamp(
      0,
      totalSeconds,
    );
    final persisted = current.session.copyWith(
      duration: duration,
      endTime: null,
      completed: false,
    );

    await _sessionRepository.save(persisted);
    _timer?.cancel();
    _timer = null;

    emit(
      SessionPaused(
        session: persisted,
        subject: _subject,
        totalSeconds: totalSeconds,
        remainingSeconds: current.remainingSeconds,
      ),
    );
  }

  Future<void> resumeSession() async {
    final current = state;
    if (current is! SessionPaused) return;

    final remaining = current.remainingSeconds;
    final now = DateTime.now();
    final session = current.session.copyWith(
      startTime: now.subtract(Duration(seconds: totalSeconds - remaining)),
    );

    _startSessionTicker(session);
    emit(
      SessionActive(
        session: session,
        subject: _subject,
        totalSeconds: totalSeconds,
        remainingSeconds: remaining,
      ),
    );
  }

  Future<void> finishSession() async {
    final current = state;
    final activeSession = current is SessionActive ? current : null;
    final pausedSession = current is SessionPaused ? current : null;

    if (activeSession == null && pausedSession == null) return;

    try {
      final session = activeSession?.session ?? pausedSession!.session;
      final remaining =
          activeSession?.remainingSeconds ?? pausedSession!.remainingSeconds;
      final endTime = DateTime.now();
      final elapsedSeconds = (totalSeconds - remaining).clamp(0, totalSeconds);

      final finished = session.copyWith(
        endTime: endTime,
        duration: elapsedSeconds,
        completed: true,
      );

      await _sessionRepository.save(finished);
      _timer?.cancel();
      _timer = null;

      _startBreakTicker();
      emit(
        SessionBreakActive(
          subject: _subject,
          totalSeconds: breakTotalSeconds,
          remainingSeconds: breakTotalSeconds,
        ),
      );
    } catch (error) {
      emit(SessionError(error.toString()));
    }
  }

  Future<void> completeBreak() async {
    if (state is! SessionBreakActive) return;

    _timer?.cancel();
    _timer = null;

    emit(
      SessionBreakComplete(subject: _subject, totalSeconds: breakTotalSeconds),
    );
  }

  Future<void> cancelSession() async {
    final current = state;
    final activeSession = current is SessionActive ? current : null;
    final pausedSession = current is SessionPaused ? current : null;

    if (activeSession == null && pausedSession == null) return;

    try {
      final session = activeSession?.session ?? pausedSession!.session;
      final cancelled = session.copyWith(
        endTime: DateTime.now(),
        completed: false,
      );
      await _sessionRepository.save(cancelled);
      _timer?.cancel();
      _timer = null;
      emit(SessionError('Session cancelled'));
    } catch (error) {
      emit(SessionError(error.toString()));
    }
  }

  void _startSessionTicker(StudySession session) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsedSeconds = _elapsedSeconds(session.startTime, DateTime.now());
      final remainingSeconds = (totalSeconds - elapsedSeconds).clamp(
        0,
        totalSeconds,
      );

      if (remainingSeconds <= 0) {
        _timer?.cancel();
        _timer = null;
        _startBreakTicker();
        emit(
          SessionBreakActive(
            subject: _subject,
            totalSeconds: breakTotalSeconds,
            remainingSeconds: breakTotalSeconds,
          ),
        );
        return;
      }

      emit(
        SessionActive(
          session: session.copyWith(duration: totalSeconds - remainingSeconds),
          subject: _subject,
          totalSeconds: totalSeconds,
          remainingSeconds: remainingSeconds,
        ),
      );
    });
  }

  void _startBreakTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final current = state;
      if (current is! SessionBreakActive) return;

      final remaining = (current.remainingSeconds - 1).clamp(
        0,
        breakTotalSeconds,
      );

      if (remaining <= 0) {
        _timer?.cancel();
        _timer = null;
        emit(
          SessionBreakComplete(
            subject: _subject,
            totalSeconds: breakTotalSeconds,
          ),
        );
        return;
      }

      emit(
        SessionBreakActive(
          subject: _subject,
          totalSeconds: breakTotalSeconds,
          remainingSeconds: remaining,
        ),
      );
    });
  }

  int _elapsedSeconds(DateTime start, DateTime end) {
    return end.difference(start).inSeconds;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> getAllSessions() async {
    try {
      final sessions = await _sessionRepository.getAll();
      for (final session in sessions) {
        print(
          session.completed
              ? 'Session ${session.id} completed in ${session.duration} seconds.'
              : 'Session ${session.id} is not completed.',
        );
        print(session.subjectId);
        print(session.startTime);
        print(session.endTime);
      }
    } catch (error) {
      emit(SessionError(error.toString()));
    }
  }
}

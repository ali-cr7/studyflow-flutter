part of 'session_cubit.dart';

sealed class SessionState {}

final class SessionInitial extends SessionState {}

final class SessionActive extends SessionState {
  SessionActive({
    required this.session,
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  final StudySession session;
  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;

  String get formattedRemainingTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

final class SessionPaused extends SessionState {
  SessionPaused({
    required this.session,
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  final StudySession session;
  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;

  String get formattedRemainingTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

final class SessionBreakActive extends SessionState {
  SessionBreakActive({
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;

  String get formattedRemainingTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

final class SessionBreakComplete extends SessionState {
  SessionBreakComplete({required this.subject, required this.totalSeconds});

  final Subject subject;
  final int totalSeconds;
}

final class SessionError extends SessionState {
  SessionError(this.message);

  final String message;
}

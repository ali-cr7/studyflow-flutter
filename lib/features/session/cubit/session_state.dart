part of 'session_cubit.dart';

// ── Celebration ───────────────────────────────────────────────────────────────

/// Describes why a celebration card should be shown when a break starts.
/// [none] means the session completed normally with no special milestone.
enum CelebrationReason {
  none,

  /// The student finished the planned session for this specific subject.
  subjectCompleted,

  /// The student's total completed study time today reached the daily goal.
  dailyGoalReached,

  /// Both milestones happened at the same time.
  both,
}

// ── States ────────────────────────────────────────────────────────────────────

sealed class SessionState {}

final class SessionInitial extends SessionState {}

final class SessionActive extends SessionState {
  SessionActive({
    required this.session,
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isMuted = false,
    this.soundEnabled = true,
  });

  final StudySession session;
  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;
  final bool isMuted;
  final bool soundEnabled;

  String get formattedRemainingTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  SessionActive copyWith({
    StudySession? session,
    Subject? subject,
    int? totalSeconds,
    int? remainingSeconds,
    bool? isMuted,
    bool? soundEnabled,
  }) {
    return SessionActive(
      session: session ?? this.session,
      subject: subject ?? this.subject,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isMuted: isMuted ?? this.isMuted,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }
}

final class SessionPaused extends SessionState {
  SessionPaused({
    required this.session,
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isMuted = false,
    this.soundEnabled = true,
  });

  final StudySession session;
  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;
  final bool isMuted;
  final bool soundEnabled;

  String get formattedRemainingTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  SessionPaused copyWith({
    StudySession? session,
    Subject? subject,
    int? totalSeconds,
    int? remainingSeconds,
    bool? isMuted,
    bool? soundEnabled,
  }) {
    return SessionPaused(
      session: session ?? this.session,
      subject: subject ?? this.subject,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isMuted: isMuted ?? this.isMuted,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }
}

final class SessionBreakActive extends SessionState {
  SessionBreakActive({
    required this.subject,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.celebrationReason = CelebrationReason.none,
  });

  final Subject subject;
  final int totalSeconds;
  final int remainingSeconds;

  /// Non-none when a milestone was just hit — drives the in-app celebration card.
  final CelebrationReason celebrationReason;

  bool get hasCelebration => celebrationReason != CelebrationReason.none;

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

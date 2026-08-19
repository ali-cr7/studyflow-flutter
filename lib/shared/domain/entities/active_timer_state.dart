enum ActiveTimerPhase {
  idle,
  study,
  breakTime,
  paused,
}

class ActiveTimerState {
  const ActiveTimerState({
    required this.id,
    required this.phase,
    required this.subjectId,
    required this.plannedDurationSeconds,
    required this.accumulatedSeconds,
    required this.createdAt,
    required this.updatedAt,
    this.sessionId,
    this.startedAt,
    this.endsAt,
  });

  static const singletonId = 1;

  final int id;
  final ActiveTimerPhase phase;
  final int subjectId;
  final int? sessionId;
  final DateTime? startedAt;
  final DateTime? endsAt;
  final int accumulatedSeconds;
  final int plannedDurationSeconds;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isRunning =>
      phase == ActiveTimerPhase.study || phase == ActiveTimerPhase.breakTime;

  bool get isPaused => phase == ActiveTimerPhase.paused;

  int elapsedSeconds(DateTime now) {
    if (!isRunning || startedAt == null) {
      return accumulatedSeconds.clamp(0, plannedDurationSeconds);
    }

    final elapsed = accumulatedSeconds + now.difference(startedAt!).inSeconds;
    return elapsed.clamp(0, plannedDurationSeconds);
  }

  int remainingSeconds(DateTime now) {
    final remaining = plannedDurationSeconds - elapsedSeconds(now);
    return remaining.clamp(0, plannedDurationSeconds);
  }

  bool isExpired(DateTime now) {
    final end = endsAt;
    return isRunning && end != null && !now.isBefore(end);
  }

  ActiveTimerState copyWith({
    int? id,
    ActiveTimerPhase? phase,
    int? subjectId,
    int? sessionId,
    DateTime? startedAt,
    DateTime? endsAt,
    int? accumulatedSeconds,
    int? plannedDurationSeconds,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearSessionId = false,
    bool clearStartedAt = false,
    bool clearEndsAt = false,
  }) {
    return ActiveTimerState(
      id: id ?? this.id,
      phase: phase ?? this.phase,
      subjectId: subjectId ?? this.subjectId,
      sessionId: clearSessionId ? null : (sessionId ?? this.sessionId),
      startedAt: clearStartedAt ? null : (startedAt ?? this.startedAt),
      endsAt: clearEndsAt ? null : (endsAt ?? this.endsAt),
      accumulatedSeconds: accumulatedSeconds ?? this.accumulatedSeconds,
      plannedDurationSeconds:
          plannedDurationSeconds ?? this.plannedDurationSeconds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

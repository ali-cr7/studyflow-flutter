/// A Pomodoro or free-form study session for one subject.
class StudySession {
  const StudySession({
    required this.id,
    required this.subjectId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.completed,
    this.notes,
  });

  final int id;
  final int subjectId;
  final DateTime startTime;
  final DateTime? endTime;

  /// Actual studied duration in seconds.
  final int duration;
  final bool completed;
  final String? notes;

  /// Whether the session is still running (timer not finished).
  bool get isActive => endTime == null && !completed;

  StudySession copyWith({
    int? id,
    int? subjectId,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    bool? completed,
    String? notes,
    bool clearNotes = false,
    bool clearEndTime = false,
  }) {
    return StudySession(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      startTime: startTime ?? this.startTime,
      endTime: clearEndTime ? null : (endTime ?? this.endTime),
      duration: duration ?? this.duration,
      completed: completed ?? this.completed,
      notes: clearNotes ? null : (notes ?? this.notes),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StudySession &&
        other.id == id &&
        other.subjectId == subjectId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.duration == duration &&
        other.completed == completed &&
        other.notes == notes;
  }

  @override
  int get hashCode => Object.hash(
        id,
        subjectId,
        startTime,
        endTime,
        duration,
        completed,
        notes,
      );
}

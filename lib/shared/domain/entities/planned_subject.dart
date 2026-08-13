/// One subject slot inside a [DailyPlan].
///
/// Links a [Subject] to a calendar day with scheduling metadata.
class PlannedSubject {
  const PlannedSubject({
    required this.id,
    required this.dailyPlanId,
    required this.subjectId,
    required this.plannedMinutes,
    required this.priority,
    required this.order,
    required this.completed,
  });

  final int id;
  final int dailyPlanId;
  final int subjectId;
  final int plannedMinutes;

  /// Higher value = higher priority when auto-scheduling.
  final int priority;

  /// Display order inside the daily plan (0 = first).
  final int order;
  final bool completed;

  PlannedSubject copyWith({
    int? id,
    int? dailyPlanId,
    int? subjectId,
    int? plannedMinutes,
    int? priority,
    int? order,
    bool? completed,
  }) {
    return PlannedSubject(
      id: id ?? this.id,
      dailyPlanId: dailyPlanId ?? this.dailyPlanId,
      subjectId: subjectId ?? this.subjectId,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      priority: priority ?? this.priority,
      order: order ?? this.order,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlannedSubject &&
        other.id == id &&
        other.dailyPlanId == dailyPlanId &&
        other.subjectId == subjectId &&
        other.plannedMinutes == plannedMinutes &&
        other.priority == priority &&
        other.order == order &&
        other.completed == completed;
  }

  @override
  int get hashCode => Object.hash(
        id,
        dailyPlanId,
        subjectId,
        plannedMinutes,
        priority,
        order,
        completed,
      );
}

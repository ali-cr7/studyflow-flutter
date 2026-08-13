import 'package:study_planner/shared/domain/entities/planned_subject.dart';

/// Aggregate root for a single day's study schedule.
///
/// In the domain model, [subjects] is part of the plan. In Isar, subjects are
/// stored in a separate table and assembled by the repository.
class DailyPlan {
  const DailyPlan({
    required this.id,
    required this.date,
    required this.subjects,
  });

  final int id;

  /// Calendar date normalized to local midnight.
  final DateTime date;
  final List<PlannedSubject> subjects;

  /// Total planned minutes across all subjects for this day.
  int get totalPlannedMinutes =>
      subjects.fold(0, (sum, item) => sum + item.plannedMinutes);

  /// Completed planned minutes for this day.
  int get completedPlannedMinutes => subjects
      .where((item) => item.completed)
      .fold(0, (sum, item) => sum + item.plannedMinutes);

  DailyPlan copyWith({
    int? id,
    DateTime? date,
    List<PlannedSubject>? subjects,
  }) {
    return DailyPlan(
      id: id ?? this.id,
      date: date ?? this.date,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DailyPlan &&
        other.id == id &&
        other.date.year == date.year &&
        other.date.month == date.month &&
        other.date.day == date.day &&
        _listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode => Object.hash(id, date.year, date.month, date.day, subjects);
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

import 'package:study_planner/shared/data/database/collections/planned_subject_collection.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';

abstract final class PlannedSubjectMapper {
  static PlannedSubject toDomain(PlannedSubjectCollection collection) {
    return PlannedSubject(
      id: collection.id,
      dailyPlanId: collection.dailyPlanId,
      subjectId: collection.subjectId,
      plannedMinutes: collection.plannedMinutes,
      priority: collection.priority,
      order: collection.sortOrder,
      completed: collection.completed,
    );
  }

  static PlannedSubjectCollection toCollection(PlannedSubject subject) {
    final collection = PlannedSubjectCollection()
      ..dailyPlanId = subject.dailyPlanId
      ..subjectId = subject.subjectId
      ..plannedMinutes = subject.plannedMinutes
      ..priority = subject.priority
      ..sortOrder = subject.order
      ..completed = subject.completed;

    if (subject.id != 0) {
      collection.id = subject.id;
    }

    return collection;
  }
}

import 'package:study_planner/core/utils/date_utils.dart';
import 'package:study_planner/data/database/collections/daily_plan_collection.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';

abstract final class DailyPlanMapper {
  static DailyPlan toDomain(
    DailyPlanCollection collection,
    List<PlannedSubject> subjects,
  ) {
    return DailyPlan(
      id: collection.id,
      date: collection.date,
      subjects: List.unmodifiable(subjects),
    );
  }

  static DailyPlanCollection toCollection(DailyPlan plan) {
    final collection = DailyPlanCollection()
      ..date = normalizeToLocalDate(plan.date);

    if (plan.id != 0) {
      collection.id = plan.id;
    }

    return collection;
  }
}

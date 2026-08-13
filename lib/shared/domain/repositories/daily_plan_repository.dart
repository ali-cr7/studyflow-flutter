import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';

/// Contract for daily planner aggregates.
abstract class DailyPlanRepository {
  /// Loads a plan for [date], or `null` if none exists yet.
  Future<DailyPlan?> getByDate(DateTime date);

  /// Returns an existing plan or creates an empty one for [date].
  Future<DailyPlan> getOrCreateForDate(DateTime date);

  /// Saves the plan header and all [DailyPlan.subjects] in one transaction.
  Future<void> save(DailyPlan plan);

  /// Updates a single planned subject row.
  Future<void> updatePlannedSubject(PlannedSubject plannedSubject);

  /// Removes one planned subject from a daily plan.
  Future<void> deletePlannedSubject(int plannedSubjectId);

  /// Reorders subjects by their [orderedPlannedSubjectIds] list.
  Future<void> reorderPlannedSubjects(List<int> orderedPlannedSubjectIds);
}

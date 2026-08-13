import 'package:isar/isar.dart';

part 'planned_subject_collection.g.dart';

/// A subject entry inside a [DailyPlanCollection].
@collection
class PlannedSubjectCollection {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('sortOrder')])
  late int dailyPlanId;

  late int subjectId;

  late int plannedMinutes;

  /// Higher value = higher priority when auto-scheduling.
  late int priority;

  /// Display order inside today's plan (0 = first).
  late int sortOrder;

  late bool completed;
}

import 'package:isar/isar.dart';

part 'daily_plan_collection.g.dart';

/// One planner row per calendar day.
///
/// Subjects for the day are stored in [PlannedSubjectCollection] and linked
/// via [PlannedSubjectCollection.dailyPlanId], not embedded here.
@collection
class DailyPlanCollection {
  Id id = Isar.autoIncrement;

  /// Start of the local calendar day (normalized in the repository layer).
  @Index(unique: true)
  late DateTime date;
}

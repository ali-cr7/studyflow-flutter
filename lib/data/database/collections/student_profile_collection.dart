import 'package:isar/isar.dart';

part 'student_profile_collection.g.dart';

/// Local persistence model for the single student profile on this device.
///
/// There is only ever one profile row (`id == 1`). Domain entities live in
/// feature layers; this class is infrastructure-only.
@collection
class StudentProfileCollection {
  Id id = 1;

  late String name;

  late String grade;

  /// Total minutes the student wants to study each day.
  late int dailyGoalMinutes;

  /// Minutes from midnight, e.g. 7:30 AM = 450.
  late int wakeUpTime;

  /// Minutes from midnight, e.g. 10:30 PM = 1350.
  late int sleepTime;

  /// Preferred Pomodoro / study block length in minutes.
  late int preferredSessionDuration;
}

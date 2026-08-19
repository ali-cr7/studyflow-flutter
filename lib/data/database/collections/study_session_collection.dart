import 'package:isar/isar.dart';

part 'study_session_collection.g.dart';

/// A completed or in-progress Pomodoro / study session.
@collection
class StudySessionCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late int subjectId;

  @Index()
  late DateTime startTime;

  DateTime? endTime;

  /// Actual studied duration in seconds (may differ from planned duration).
  late int duration;

  late bool completed;

  String? notes;
}

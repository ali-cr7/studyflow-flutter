import 'package:isar/isar.dart';

part 'active_timer_collection.g.dart';

@collection
class ActiveTimerCollection {
  Id id = 1;

  @Index()
  late String phase;

  @Index()
  late int subjectId;

  int? sessionId;

  DateTime? startedAt;

  DateTime? endsAt;

  late int accumulatedSeconds;

  late int plannedDurationSeconds;

  late DateTime createdAt;

  late DateTime updatedAt;
}

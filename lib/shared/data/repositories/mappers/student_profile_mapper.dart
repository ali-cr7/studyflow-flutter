import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/shared/data/database/collections/student_profile_collection.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

/// Converts between [StudentProfile] and [StudentProfileCollection].
abstract final class StudentProfileMapper {
  static StudentProfile toDomain(StudentProfileCollection collection) {
    return StudentProfile(
      id: collection.id,
      name: collection.name,
      grade: collection.grade,
      dailyGoalMinutes: collection.dailyGoalMinutes,
      wakeUpTime: DayTime.fromMinutesFromMidnight(collection.wakeUpTime),
      sleepTime: DayTime.fromMinutesFromMidnight(collection.sleepTime),
      preferredSessionDuration: collection.preferredSessionDuration,
    );
  }

  static StudentProfileCollection toCollection(StudentProfile profile) {
    return StudentProfileCollection()
      ..id = DatabaseConstants.singletonId
      ..name = profile.name
      ..grade = profile.grade
      ..dailyGoalMinutes = profile.dailyGoalMinutes
      ..wakeUpTime = profile.wakeUpTime.minutesFromMidnight
      ..sleepTime = profile.sleepTime.minutesFromMidnight
      ..preferredSessionDuration = profile.preferredSessionDuration;
  }
}

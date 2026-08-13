import 'package:study_planner/shared/domain/value_objects/day_time.dart';

/// The student's identity and daily study preferences.
///
/// One profile exists per device. The domain layer expresses wake/sleep as
/// [DayTime] value objects instead of raw ints or Flutter [TimeOfDay].
class StudentProfile {
  const StudentProfile({
    required this.id,
    required this.name,
    required this.grade,
    required this.dailyGoalMinutes,
    required this.wakeUpTime,
    required this.sleepTime,
    required this.preferredSessionDuration,
  });

  /// Always `1` for the singleton profile row.
  final int id;
  final String name;
  final String grade;

  /// Total minutes the student aims to study each day.
  final int dailyGoalMinutes;
  final DayTime wakeUpTime;
  final DayTime sleepTime;

  /// Default Pomodoro block length in minutes.
  final int preferredSessionDuration;

  StudentProfile copyWith({
    int? id,
    String? name,
    String? grade,
    int? dailyGoalMinutes,
    DayTime? wakeUpTime,
    DayTime? sleepTime,
    int? preferredSessionDuration,
  }) {
    return StudentProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      sleepTime: sleepTime ?? this.sleepTime,
      preferredSessionDuration:
          preferredSessionDuration ?? this.preferredSessionDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StudentProfile &&
        other.id == id &&
        other.name == name &&
        other.grade == grade &&
        other.dailyGoalMinutes == dailyGoalMinutes &&
        other.wakeUpTime == wakeUpTime &&
        other.sleepTime == sleepTime &&
        other.preferredSessionDuration == preferredSessionDuration;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        grade,
        dailyGoalMinutes,
        wakeUpTime,
        sleepTime,
        preferredSessionDuration,
      );
}

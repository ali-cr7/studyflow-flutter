/// Clock time without a calendar date.
///
/// Used for wake/sleep preferences. Stored as minutes-from-midnight in Isar;
/// repositories convert between this value object and the persisted int.
class DayTime {
  const DayTime({required this.hour, required this.minute})
      : assert(hour >= 0 && hour < 24),
        assert(minute >= 0 && minute < 60);

  final int hour;
  final int minute;

  /// Total minutes elapsed since midnight (0–1439).
  int get minutesFromMidnight => (hour * 60) + minute;

  factory DayTime.fromMinutesFromMidnight(int minutes) {
    assert(minutes >= 0 && minutes < 24 * 60);
    return DayTime(hour: minutes ~/ 60, minute: minutes % 60);
  }

  DayTime copyWith({int? hour, int? minute}) {
    return DayTime(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DayTime && other.hour == hour && other.minute == minute;
  }

  @override
  int get hashCode => Object.hash(hour, minute);

  @override
  String toString() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

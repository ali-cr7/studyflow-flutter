enum StatisticsStatus { initial, loading, loaded, empty, failure }

enum StatisticsPeriod { today, week, month, year, allTime }

class StatisticsState {
  const StatisticsState({
    this.status = StatisticsStatus.initial,
    this.snapshot,
    this.message,
  });

  final StatisticsStatus status;
  final StatisticsSnapshot? snapshot;
  final String? message;

  factory StatisticsState.initial() => const StatisticsState();
  factory StatisticsState.loading() =>
      const StatisticsState(status: StatisticsStatus.loading);
  factory StatisticsState.loaded(StatisticsSnapshot snapshot) =>
      StatisticsState(status: StatisticsStatus.loaded, snapshot: snapshot);
  factory StatisticsState.empty() =>
      const StatisticsState(status: StatisticsStatus.empty);
  factory StatisticsState.failure(String message) =>
      StatisticsState(status: StatisticsStatus.failure, message: message);
}

class StatisticsSnapshot {
  const StatisticsSnapshot({
    required this.period,
    required this.subtitle,
    required this.studyMinutes,
    required this.sessionCount,
    required this.planCompletionPercent,
    required this.currentStreak,
    required this.goalMinutes,
    required this.chartPoints,
    required this.subjectBreakdown,
    required this.plannedMinutes,
    required this.completedPlannedMinutes,
    required this.activeDays,
    required this.longestStreak,
    required this.insights,
    required this.bestRecords,
    required this.recentAchievements,
  });

  final StatisticsPeriod period;
  final String subtitle;
  /// Completed study duration in seconds. The name is kept for API stability.
  final int studyMinutes;
  final int sessionCount;
  final int planCompletionPercent;
  final int currentStreak;
  /// Daily goal duration in seconds. The name is kept for API stability.
  final int goalMinutes;
  final List<ChartPoint> chartPoints;
  final List<SubjectBreakdown> subjectBreakdown;
  /// Planned duration in seconds. The name is kept for API stability.
  final int plannedMinutes;

  /// Completed planned duration in seconds. The name is kept for API stability.
  final int completedPlannedMinutes;
  final int activeDays;
  final int longestStreak;
  final List<String> insights;
  final List<BestRecord> bestRecords;
  final List<String> recentAchievements;
}

class ChartPoint {
  const ChartPoint({required this.label, required this.minutes});

  final String label;

  /// Duration in seconds. The name is kept for API stability.
  final int minutes;
}

class SubjectBreakdown {
  const SubjectBreakdown({
    required this.name,
    required this.minutes,
    required this.percent,
    required this.color,
  });

  final String name;
  /// Duration in seconds. The name is kept for API stability.
  final int minutes;
  final int percent;
  final int color;
}

class BestRecord {
  const BestRecord({required this.label, required this.value});

  final String label;
  final String value;
}

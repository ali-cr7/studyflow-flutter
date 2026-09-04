enum StatisticsStatus { initial, loading, loaded, empty, failure }

enum StatisticsPeriod { today, week, month, year, allTime }

// ── Insight model ─────────────────────────────────────────────────────────────

/// The type of a statistics insight.
/// The presentation layer uses this to build a localized sentence.
enum StatisticsInsightType {
  noSessions,
  mostStudiedSubject,
  planCompletion,
  currentStreak,
  longestStreak,
}

/// A single structured insight produced by the repository.
/// Contains raw data only — no localized strings.
class StatisticsInsight {
  const StatisticsInsight({
    required this.type,
    this.subjectName,
    this.percent,
    this.count,
    this.period,
  });

  final StatisticsInsightType type;

  /// Populated for [StatisticsInsightType.mostStudiedSubject].
  final String? subjectName;

  /// Populated for [StatisticsInsightType.planCompletion].
  final int? percent;

  /// Populated for [StatisticsInsightType.currentStreak] and
  /// [StatisticsInsightType.longestStreak].
  final int? count;

  /// Populated for [StatisticsInsightType.mostStudiedSubject].
  final StatisticsPeriod? period;
}

// ── Best-records model ────────────────────────────────────────────────────────

/// Structured best-records data.
/// All string labels are derived in the presentation layer.
class StatisticsBestRecordsData {
  const StatisticsBestRecordsData({
    this.longestStreakDays,
    this.mostProductiveDay,
    this.mostStudiedSubjectName,
    this.longestSessionSeconds,
  });

  /// Null when no streak data is available.
  final int? longestStreakDays;

  /// The calendar date of the most productive day.
  /// Null when no session data is available.
  /// The widget formats the weekday name using the current locale.
  final DateTime? mostProductiveDay;

  /// Null when no subject data is available.
  final String? mostStudiedSubjectName;

  /// Duration in seconds. Null when no session data is available.
  final int? longestSessionSeconds;

  bool get isEmpty =>
      longestStreakDays == null &&
      mostProductiveDay == null &&
      mostStudiedSubjectName == null &&
      longestSessionSeconds == null;
}

// ── Main state ────────────────────────────────────────────────────────────────

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

// ── Snapshot ──────────────────────────────────────────────────────────────────

class StatisticsSnapshot {
  const StatisticsSnapshot({
    required this.period,
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

  /// Structured insights — localized by the presentation layer.
  final List<StatisticsInsight> insights;

  /// Structured best-records — labels localized by the presentation layer.
  final StatisticsBestRecordsData bestRecords;

  final List<String> recentAchievements;
}

// ── Chart point ───────────────────────────────────────────────────────────────

class ChartPoint {
  const ChartPoint({required this.label, required this.minutes});

  /// Locale-neutral key used by the chart widget to format the axis label.
  ///
  /// Values by period:
  /// - today    → 24-h hour string: '6', '9', '12', '15', '18', '21'
  /// - week     → ISO-8601 date: '2026-08-19'
  /// - month    → week-index string: '0', '1', '2', '3', '4'
  /// - year     → month number string: '1' .. '12'
  /// - allTime  → month number string: '1' .. '12'
  final String label;

  /// Duration in seconds. The name is kept for API stability.
  final int minutes;
}

// ── Subject breakdown ─────────────────────────────────────────────────────────

class SubjectBreakdown {
  const SubjectBreakdown({
    required this.name,
    required this.minutes,
    required this.percent,
    required this.color,
  });

  /// May be null when the subject record no longer exists.
  /// The widget falls back to l10n.na.
  final String? name;

  /// Duration in seconds. The name is kept for API stability.
  final int minutes;
  final int percent;
  final int color;
}

// ── Best record (legacy — kept for any external references) ──────────────────

/// Kept for compatibility with any code still referencing [BestRecord].
/// New code should use [StatisticsBestRecordsData].
@Deprecated('Use StatisticsBestRecordsData instead')
class BestRecord {
  const BestRecord({required this.label, required this.value});

  final String label;
  final String value;
}

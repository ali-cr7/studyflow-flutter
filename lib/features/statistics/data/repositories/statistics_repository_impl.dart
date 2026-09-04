import 'package:study_planner/features/statistics/data/repositories/statistics_repository.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/achievement_repository.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  StatisticsRepositoryImpl({
    required StudentProfileRepository studentProfileRepository,
    required SubjectRepository subjectRepository,
    required DailyPlanRepository dailyPlanRepository,
    required StudySessionRepository studySessionRepository,
    required AchievementRepository achievementRepository,
    required AppSettingsRepository appSettingsRepository,
  }) : _studentProfileRepository = studentProfileRepository,
       _subjectRepository = subjectRepository,
       _dailyPlanRepository = dailyPlanRepository,
       _studySessionRepository = studySessionRepository,
       _achievementRepository = achievementRepository,
       _appSettingsRepository = appSettingsRepository;

  final StudentProfileRepository _studentProfileRepository;
  final SubjectRepository _subjectRepository;
  final DailyPlanRepository _dailyPlanRepository;
  final StudySessionRepository _studySessionRepository;
  final AchievementRepository _achievementRepository;
  final AppSettingsRepository _appSettingsRepository;

  @override
  Future<StatisticsSnapshot> loadStatistics({
    required StatisticsPeriod period,
  }) async {
    final profile = await _studentProfileRepository.getProfile();
    final subjects = await _subjectRepository.getAll();
    final sessions = await _studySessionRepository.getAll();
    final achievements = await _achievementRepository.getAll();
    final settings = await _appSettingsRepository.getSettings();

    final relevantSessions = sessions
        .where((s) => s.completed && _isInPeriod(s.startTime, period))
        .toList();

    final range = _periodRange(period);
    final dailyPlans = await _loadPlansForRange(range.start, range.end);

    final studySeconds = relevantSessions.fold<int>(
      0,
      (sum, s) => sum + s.duration,
    );
    final sessionCount = relevantSessions.length;
    final chartPoints = _buildChartPoints(relevantSessions, period);
    final subjectBreakdown = _buildSubjectBreakdown(relevantSessions, subjects);
    final planTotals = _buildPlanTotals(dailyPlans, range);
    final currentStreak = _calculateCurrentStreak(relevantSessions);
    final activeDays = _uniqueStudyDays(relevantSessions).length;
    final longestStreak = _calculateLongestStreak(relevantSessions);

    final insights = _buildInsights(
      studySeconds: studySeconds,
      sessionCount: sessionCount,
      planCompletionPercent: planTotals.completionPercent,
      subjectBreakdown: subjectBreakdown,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      period: period,
    );

    final bestRecords = _buildBestRecords(relevantSessions, subjectBreakdown);

    final recentAchievements = achievements
        .take(3)
        .map((a) => a.type.name)
        .toList();

    return StatisticsSnapshot(
      period: period,
      studyMinutes: studySeconds,
      sessionCount: sessionCount,
      planCompletionPercent: planTotals.completionPercent,
      currentStreak: currentStreak,
      goalMinutes: (profile?.dailyGoalMinutes ?? settings.studyDuration) * 60,
      chartPoints: chartPoints,
      subjectBreakdown: subjectBreakdown,
      plannedMinutes: planTotals.plannedMinutes,
      completedPlannedMinutes: planTotals.completedMinutes,
      activeDays: activeDays,
      longestStreak: longestStreak,
      insights: insights,
      bestRecords: bestRecords,
      recentAchievements: recentAchievements,
    );
  }

  // ── Period helpers ────────────────────────────────────────────────────────

  bool _isInPeriod(DateTime date, StatisticsPeriod period) {
    final range = _periodRange(period);
    return !date.isBefore(range.start) && !date.isAfter(range.end);
  }

  ({DateTime start, DateTime end}) _periodRange(StatisticsPeriod period) {
    final now = DateTime.now();
    switch (period) {
      case StatisticsPeriod.today:
        final start = DateTime(now.year, now.month, now.day);
        return (
          start: start,
          end: start
              .add(const Duration(days: 1))
              .subtract(const Duration(seconds: 1)),
        );
      case StatisticsPeriod.week:
        final start = now.subtract(Duration(days: now.weekday - 1));
        final normalizedStart = DateTime(start.year, start.month, start.day);
        return (
          start: normalizedStart,
          end: normalizedStart.add(
            const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
          ),
        );
      case StatisticsPeriod.month:
        final start = DateTime(now.year, now.month, 1);
        return (
          start: start,
          end: DateTime(now.year, now.month + 1, 0, 23, 59, 59),
        );
      case StatisticsPeriod.year:
        final start = DateTime(now.year, 1, 1);
        return (start: start, end: DateTime(now.year, 12, 31, 23, 59, 59));
      case StatisticsPeriod.allTime:
        return (
          start: DateTime(2000, 1, 1),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );
    }
  }

  // ── Plan loading ──────────────────────────────────────────────────────────

  Future<List<DailyPlan>> _loadPlansForRange(
    DateTime start,
    DateTime end,
  ) async {
    final plans = <DailyPlan>[];
    var cursor = DateTime(start.year, start.month, start.day);
    final lastDay = DateTime(end.year, end.month, end.day);
    while (!cursor.isAfter(lastDay)) {
      final plan = await _dailyPlanRepository.getByDate(cursor);
      if (plan != null) plans.add(plan);
      cursor = cursor.add(const Duration(days: 1));
    }
    return plans;
  }

  _PlanTotals _buildPlanTotals(
    List<DailyPlan> plans,
    ({DateTime start, DateTime end}) range,
  ) {
    var planned = 0;
    var completed = 0;
    for (final plan in plans) {
      final isInRange =
          !plan.date.isBefore(range.start) && !plan.date.isAfter(range.end);
      if (!isInRange) continue;
      planned += plan.totalPlannedMinutes;
      completed += plan.completedPlannedMinutes;
    }
    return _PlanTotals(
      plannedMinutes: planned * 60,
      completedMinutes: completed * 60,
      completionPercent: planned == 0
          ? 0
          : ((completed / planned) * 100).round(),
    );
  }

  // ── Chart points ──────────────────────────────────────────────────────────
  //
  // Chart labels are locale-neutral keys:
  //   today    → 24-h hour string  '6', '9', '12', '15', '18', '21'
  //   week     → ISO-8601 date     '2026-08-19'
  //   month    → week-index string '0', '1', '2', '3', '4'
  //   year     → month number      '1' .. '12'
  //   allTime  → month number      '1' .. '12'
  //
  // The StatisticsActivityChart widget converts these keys to localized
  // labels using intl.DateFormat.

  List<ChartPoint> _buildChartPoints(
    List<StudySession> sessions,
    StatisticsPeriod period,
  ) {
    if (sessions.isEmpty) return const [];

    final range = _periodRange(period);
    final map = <String, int>{};

    for (final session in sessions) {
      final key = _chartKeyForPeriod(period, session.startTime, range.start);
      map.update(
        key,
        (v) => v + session.duration,
        ifAbsent: () => session.duration,
      );
    }

    switch (period) {
      case StatisticsPeriod.today:
        return _rangeByHours(map);
      case StatisticsPeriod.week:
        return _rangeByDays(range.start, map, 7);
      case StatisticsPeriod.month:
        return _rangeByWeeks(map, 5);
      case StatisticsPeriod.year:
      case StatisticsPeriod.allTime:
        return _rangeByMonths(range.start, range.end, map);
    }
  }

  /// Hour slots for the today period.
  /// Labels are 24-h hour strings: '6', '9', '12', '15', '18', '21'.
  List<ChartPoint> _rangeByHours(Map<String, int> map) {
    const slots = ['6', '9', '12', '15', '18', '21'];
    return slots
        .map((h) => ChartPoint(label: h, minutes: map[h] ?? 0))
        .toList();
  }

  /// One bar per day; label is the ISO-8601 date string ('2026-08-19').
  List<ChartPoint> _rangeByDays(
    DateTime start,
    Map<String, int> map,
    int count,
  ) {
    final points = <ChartPoint>[];
    for (var i = 0; i < count; i++) {
      final date = start.add(Duration(days: i));
      final key = date.toIso8601String().substring(0, 10);
      points.add(ChartPoint(label: key, minutes: map[key] ?? 0));
    }
    return points;
  }

  /// One bar per week; label is the zero-based week index as a string ('0'..'4').
  List<ChartPoint> _rangeByWeeks(Map<String, int> map, int count) {
    return List.generate(
      count,
      (i) => ChartPoint(label: '$i', minutes: map['week-$i'] ?? 0),
    );
  }

  /// One bar per month; label is the month number as a string ('1'..'12').
  List<ChartPoint> _rangeByMonths(
    DateTime start,
    DateTime end,
    Map<String, int> map,
  ) {
    final points = <ChartPoint>[];
    for (var month = start.month; month <= end.month; month++) {
      points.add(ChartPoint(label: '$month', minutes: map['$month'] ?? 0));
    }
    return points;
  }

  String _chartKeyForPeriod(
    StatisticsPeriod period,
    DateTime date,
    DateTime start,
  ) {
    switch (period) {
      case StatisticsPeriod.today:
        final hour = date.hour;
        if (hour < 9) return '6';
        if (hour < 12) return '9';
        if (hour < 15) return '12';
        if (hour < 18) return '15';
        if (hour < 21) return '18';
        return '21';
      case StatisticsPeriod.week:
        return date.toIso8601String().substring(0, 10);
      case StatisticsPeriod.month:
        final weekIndex = ((date.difference(start).inDays) / 7).floor();
        return 'week-$weekIndex';
      case StatisticsPeriod.year:
      case StatisticsPeriod.allTime:
        return '${date.month}';
    }
  }

  // ── Subject breakdown ─────────────────────────────────────────────────────

  List<SubjectBreakdown> _buildSubjectBreakdown(
    List<StudySession> sessions,
    List<Subject> subjects,
  ) {
    final bySubject = <int, int>{};
    for (final session in sessions) {
      bySubject[session.subjectId] =
          (bySubject[session.subjectId] ?? 0) + session.duration;
    }
    if (bySubject.isEmpty) return const [];

    final total = bySubject.values.fold<int>(0, (sum, v) => sum + v);
    final subjectMap = {for (final s in subjects) s.id: s};

    final entries = bySubject.entries.map((entry) {
      final subject = subjectMap[entry.key];
      // Return null name when subject not found; presentation shows l10n.na.
      return SubjectBreakdown(
        name: subject?.name,
        minutes: entry.value,
        percent: total == 0 ? 0 : ((entry.value / total) * 100).round(),
        color: subject?.color ?? 0xFF4C6FFF,
      );
    }).toList();

    entries.sort((a, b) => b.minutes.compareTo(a.minutes));
    return entries;
  }

  // ── Streak helpers ────────────────────────────────────────────────────────

  int _calculateCurrentStreak(List<StudySession> sessions) {
    final dates = _uniqueStudyDays(sessions);
    if (dates.isEmpty) return 0;
    var streak = 0;
    var cursor = DateTime.now();
    while (true) {
      final normalized = DateTime(cursor.year, cursor.month, cursor.day);
      if (dates.contains(normalized)) {
        streak++;
        cursor = cursor.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  int _calculateLongestStreak(List<StudySession> sessions) {
    final dates = _uniqueStudyDays(sessions);
    if (dates.isEmpty) return 0;
    dates.sort();
    var longest = 1;
    var current = 1;
    for (var i = 1; i < dates.length; i++) {
      if (dates[i].difference(dates[i - 1]).inDays == 1) {
        current++;
      } else {
        current = 1;
      }
      if (current > longest) longest = current;
    }
    return longest;
  }

  List<DateTime> _uniqueStudyDays(List<StudySession> sessions) {
    final unique = <DateTime>{};
    for (final session in sessions) {
      unique.add(
        DateTime(
          session.startTime.year,
          session.startTime.month,
          session.startTime.day,
        ),
      );
    }
    return unique.toList()..sort();
  }

  // ── Structured insights ───────────────────────────────────────────────────
  //
  // Returns raw structured data only. No localized strings.

  List<StatisticsInsight> _buildInsights({
    required int studySeconds,
    required int sessionCount,
    required int planCompletionPercent,
    required List<SubjectBreakdown> subjectBreakdown,
    required int currentStreak,
    required int longestStreak,
    required StatisticsPeriod period,
  }) {
    if (studySeconds == 0 || sessionCount == 0) {
      return const [StatisticsInsight(type: StatisticsInsightType.noSessions)];
    }

    final insights = <StatisticsInsight>[];

    if (subjectBreakdown.isNotEmpty) {
      insights.add(
        StatisticsInsight(
          type: StatisticsInsightType.mostStudiedSubject,
          subjectName: subjectBreakdown.first.name,
          period: period,
        ),
      );
    }

    if (planCompletionPercent > 0) {
      insights.add(
        StatisticsInsight(
          type: StatisticsInsightType.planCompletion,
          percent: planCompletionPercent,
        ),
      );
    }

    if (currentStreak > 0) {
      insights.add(
        StatisticsInsight(
          type: StatisticsInsightType.currentStreak,
          count: currentStreak,
        ),
      );
    }

    if (longestStreak > 0) {
      insights.add(
        StatisticsInsight(
          type: StatisticsInsightType.longestStreak,
          count: longestStreak,
        ),
      );
    }

    return insights.take(3).toList();
  }

  // ── Structured best records ───────────────────────────────────────────────
  //
  // Returns raw typed data. No English strings, no formatted durations.

  StatisticsBestRecordsData _buildBestRecords(
    List<StudySession> sessions,
    List<SubjectBreakdown> subjectBreakdown,
  ) {
    if (sessions.isEmpty) {
      return const StatisticsBestRecordsData();
    }

    // Longest single session (in seconds)
    final longestSession = sessions.reduce(
      (best, s) => s.duration > best.duration ? s : best,
    );

    // Most productive calendar day
    final byDay = <String, int>{};
    for (final s in sessions) {
      final key = DateTime(
        s.startTime.year,
        s.startTime.month,
        s.startTime.day,
      ).toIso8601String();
      byDay[key] = (byDay[key] ?? 0) + s.duration;
    }
    final bestDayEntry = byDay.entries.reduce(
      (best, e) => e.value > best.value ? e : best,
    );
    final mostProductiveDay = DateTime.parse(bestDayEntry.key);

    return StatisticsBestRecordsData(
      // longestStreakDays is not computed here because streak requires
      // the full session list — pass null; presentation shows '—' via l10n.na.
      longestStreakDays: null,
      mostProductiveDay: mostProductiveDay,
      mostStudiedSubjectName: subjectBreakdown.isNotEmpty
          ? subjectBreakdown.first.name
          : null,
      longestSessionSeconds: longestSession.duration,
    );
  }
}

// ── Private helpers ───────────────────────────────────────────────────────────

class _PlanTotals {
  const _PlanTotals({
    required this.plannedMinutes,
    required this.completedMinutes,
    required this.completionPercent,
  });

  final int plannedMinutes;
  final int completedMinutes;
  final int completionPercent;
}

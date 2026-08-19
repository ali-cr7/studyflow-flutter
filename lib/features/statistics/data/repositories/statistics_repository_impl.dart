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
        .where(
          (session) =>
              session.completed && _isInPeriod(session.startTime, period),
        )
        .toList();
    print('Relevant sessions for period $period: ${relevantSessions.length}');

    for (final session in relevantSessions) {
      print(
        'Session: ${session.id}, Subject ID: ${session.subjectId}, Duration: ${session.duration} seconds, Start Time: ${session.startTime}',
      );
    }

    final range = _periodRange(period);
    final dailyPlans = await _loadPlansForRange(range.start, range.end);

    final studySeconds = relevantSessions.fold<int>(
      0,
      (sum, session) => sum + session.duration,
    );
    final sessionCount = relevantSessions.length;
    final chartPoints = _buildChartPoints(relevantSessions, period);
    final subjectBreakdown = _buildSubjectBreakdown(relevantSessions, subjects);
    final planTotals = _buildPlanTotals(dailyPlans, range);
    final currentStreak = _calculateCurrentStreak(relevantSessions);
    final activeDays = _uniqueStudyDays(relevantSessions).length;
    final longestStreak = _calculateLongestStreak(relevantSessions);
    final insights = _buildInsights(
      studyMinutes: studySeconds,
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
        .map((achievement) => achievement.type.name)
        .toList();

    return StatisticsSnapshot(
      period: period,
      subtitle: _subtitleForPeriod(period),
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

  Future<List<DailyPlan>> _loadPlansForRange(
    DateTime start,
    DateTime end,
  ) async {
    final plans = <DailyPlan>[];
    var cursor = DateTime(start.year, start.month, start.day);
    final lastDay = DateTime(end.year, end.month, end.day);

    while (!cursor.isAfter(lastDay)) {
      final plan = await _dailyPlanRepository.getByDate(cursor);
      if (plan != null) {
        plans.add(plan);
      }
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

  List<ChartPoint> _buildChartPoints(
    List<StudySession> sessions,
    StatisticsPeriod period,
  ) {
    if (sessions.isEmpty) return const [];

    final range = _periodRange(period);
    final dayMap = <String, int>{};

    for (final session in sessions) {
      final date = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      );
      final key = _chartKeyForPeriod(period, session.startTime, range.start);
      dayMap.update(
        key,
        (value) => value + session.duration,
        ifAbsent: () => session.duration,
      );
    }

    switch (period) {
      case StatisticsPeriod.today:
        return _rangeByHours(range.start, range.end, dayMap);
      case StatisticsPeriod.week:
        return _rangeByDays(range.start, range.end, dayMap, 7);
      case StatisticsPeriod.month:
        return _rangeByWeeks(range.start, range.end, dayMap, 5);
      case StatisticsPeriod.year:
        return _rangeByMonths(range.start, range.end, dayMap);
      case StatisticsPeriod.allTime:
        return _rangeByMonths(range.start, range.end, dayMap);
    }
  }

  List<ChartPoint> _rangeByHours(
    DateTime start,
    DateTime end,
    Map<String, int> dayMap,
  ) {
    final labels = ['6a', '9a', '12p', '3p', '6p', '9p'];
    final values = List.generate(labels.length, (_) => 0);
    for (var i = 0; i < labels.length; i++) {
      values[i] = dayMap[labels[i]] ?? 0;
    }
    return [
      ChartPoint(label: '6a', minutes: dayMap['6a'] ?? 0),
      ChartPoint(label: '9a', minutes: dayMap['9a'] ?? 0),
      ChartPoint(label: '12p', minutes: dayMap['12p'] ?? 0),
      ChartPoint(label: '3p', minutes: dayMap['3p'] ?? 0),
      ChartPoint(label: '6p', minutes: dayMap['6p'] ?? 0),
      ChartPoint(label: '9p', minutes: dayMap['9p'] ?? 0),
    ];
  }

  List<ChartPoint> _rangeByDays(
    DateTime start,
    DateTime end,
    Map<String, int> map,
    int count,
  ) {
    final points = <ChartPoint>[];
    for (var i = 0; i < count; i++) {
      final date = start.add(Duration(days: i));
      final dayLabel = _dayLabel(date.weekday);
      final value = map[date.toIso8601String().substring(0, 10)] ?? 0;
      points.add(ChartPoint(label: dayLabel, minutes: value));
    }
    return points;
  }

  List<ChartPoint> _rangeByWeeks(
    DateTime start,
    DateTime end,
    Map<String, int> map,
    int count,
  ) {
    final points = <ChartPoint>[];
    for (var i = 0; i < count; i++) {
      final key = 'week-$i';
      final value = map[key] ?? 0;
      points.add(ChartPoint(label: 'W${i + 1}', minutes: value));
    }
    return points;
  }

  List<ChartPoint> _rangeByMonths(
    DateTime start,
    DateTime end,
    Map<String, int> map,
  ) {
    final points = <ChartPoint>[];
    final months = <String>[];
    for (var month = start.month; month <= end.month; month++) {
      final monthDate = DateTime(start.year, month);
      months.add(_monthLabel(monthDate.month));
    }

    for (final label in months) {
      final key = label;
      points.add(ChartPoint(label: label, minutes: map[key] ?? 0));
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
        if (hour < 9) return '6a';
        if (hour < 12) return '9a';
        if (hour < 15) return '12p';
        if (hour < 18) return '3p';
        if (hour < 21) return '6p';
        return '9p';
      case StatisticsPeriod.week:
        return date.toIso8601String().substring(0, 10);
      case StatisticsPeriod.month:
        final weekIndex = ((date.difference(start).inDays) / 7).floor();
        return 'week-$weekIndex';
      case StatisticsPeriod.year:
      case StatisticsPeriod.allTime:
        return _monthLabel(date.month);
    }
  }

  String _dayLabel(int weekday) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[(weekday - 1) % 7];
  }

  String _monthLabel(int month) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return labels[month - 1];
  }

  List<SubjectBreakdown> _buildSubjectBreakdown(
    List<StudySession> sessions,
    List<Subject> subjects,
  ) {
    final bySubject = <int, int>{};
    for (final session in sessions) {
      final current = bySubject[session.subjectId] ?? 0;
      bySubject[session.subjectId] = current + session.duration;
    }

    if (bySubject.isEmpty) return const [];

    final total = bySubject.values.fold<int>(0, (sum, value) => sum + value);
    final subjectMap = {for (final subject in subjects) subject.id: subject};

    final entries = bySubject.entries.map((entry) {
      final subject = subjectMap[entry.key];
      final name = subject?.name ?? 'Unknown';
      final color = subject?.color ?? 0xFF4C6FFF;
      return SubjectBreakdown(
        name: name,
        minutes: entry.value,
        percent: total == 0 ? 0 : ((entry.value / total) * 100).round(),
        color: color,
      );
    }).toList();

    entries.sort((a, b) => b.minutes.compareTo(a.minutes));
    return entries;
  }

  int _calculateCurrentStreak(List<StudySession> sessions) {
    final dates = _uniqueStudyDays(sessions);
    if (dates.isEmpty) return 0;

    var streak = 0;
    var cursor = DateTime.now();
    while (true) {
      final normalized = DateTime(cursor.year, cursor.month, cursor.day);
      if (dates.contains(normalized)) {
        streak += 1;
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
      final previous = dates[i - 1];
      final currentDate = dates[i];
      if (currentDate.difference(previous).inDays == 1) {
        current += 1;
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
      final date = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      );
      unique.add(date);
    }
    final sorted = unique.toList()..sort();
    return sorted;
  }

  List<String> _buildInsights({
    required int studyMinutes,
    required int sessionCount,
    required int planCompletionPercent,
    required List<SubjectBreakdown> subjectBreakdown,
    required int currentStreak,
    required int longestStreak,
    required StatisticsPeriod period,
  }) {
    final insights = <String>[];

    if (studyMinutes == 0 || sessionCount == 0) {
      return ['No study sessions recorded yet for this period.'];
    }

    if (subjectBreakdown.isNotEmpty) {
      final topSubject = subjectBreakdown.first;
      insights.add(
        '${topSubject.name} is your most studied subject ${_periodLabel(period)}.',
      );
    }

    if (planCompletionPercent > 0) {
      insights.add(
        'You completed $planCompletionPercent% of your planned study time.',
      );
    }

    if (currentStreak > 0) {
      insights.add('Your current streak is $currentStreak days.');
    }

    if (longestStreak > 0) {
      insights.add('Your longest streak is $longestStreak days.');
    }

    return insights.take(3).toList();
  }

  String _periodLabel(StatisticsPeriod period) {
    switch (period) {
      case StatisticsPeriod.today:
        return 'today';
      case StatisticsPeriod.week:
        return 'this week';
      case StatisticsPeriod.month:
        return 'this month';
      case StatisticsPeriod.year:
        return 'this year';
      case StatisticsPeriod.allTime:
        return 'overall';
    }
  }

  List<BestRecord> _buildBestRecords(
    List<StudySession> sessions,
    List<SubjectBreakdown> subjectBreakdown,
  ) {
    if (sessions.isEmpty) return const [];

    final longSession = sessions.reduce(
      (best, session) => session.duration > best.duration ? session : best,
    );
    final byDay = <String, int>{};
    for (final session in sessions) {
      final day = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      ).toIso8601String();
      byDay.update(
        day,
        (value) => value + session.duration,
        ifAbsent: () => session.duration,
      );
    }
    final bestDay = byDay.entries.reduce(
      (best, entry) => entry.value > best.value ? entry : best,
    );
    final bestSubject = subjectBreakdown.isNotEmpty
        ? subjectBreakdown.first.name
        : 'N/A';

    return [
      const BestRecord(label: 'Longest streak', value: '—'),
      BestRecord(
        label: 'Most productive day',
        value: _dayFromDate(DateTime.parse(bestDay.key)),
      ),
      BestRecord(label: 'Most studied subject', value: bestSubject),
      BestRecord(
        label: 'Longest session',
        value: _formatDuration(longSession.duration),
      ),
    ];
  }

  String _dayFromDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[(date.weekday - 1) % 7];
  }

  static String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }

    if (hours > 0) {
      return '${hours}h';
    }

    if (minutes > 0 && remainingSeconds > 0) {
      return '${minutes}m ${remainingSeconds}s';
    }

    if (minutes > 0) {
      return '${minutes}m';
    }

    return '${remainingSeconds}s';
  }

  String _subtitleForPeriod(StatisticsPeriod period) {
    switch (period) {
      case StatisticsPeriod.today:
        return 'Today';
      case StatisticsPeriod.week:
        return 'This week';
      case StatisticsPeriod.month:
        return 'This month';
      case StatisticsPeriod.year:
        return 'This year';
      case StatisticsPeriod.allTime:
        return 'All time';
    }
  }
}

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

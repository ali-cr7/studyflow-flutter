import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/features/statistics/data/repositories/statistics_repository.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/pages/statistics_screen.dart';

class _FakeStatisticsRepository implements StatisticsRepository {
  @override
  Future<StatisticsSnapshot> loadStatistics({
    required StatisticsPeriod period,
  }) async {
    return StatisticsSnapshot(
      period: period,
      subtitle: 'This week',
      studyMinutes: 180,
      sessionCount: 4,
      planCompletionPercent: 75,
      currentStreak: 6,
      goalMinutes: 240,
      chartPoints: const [
        ChartPoint(label: 'M', minutes: 30),
        ChartPoint(label: 'T', minutes: 45),
        ChartPoint(label: 'W', minutes: 55),
        ChartPoint(label: 'T', minutes: 40),
        ChartPoint(label: 'F', minutes: 60),
      ],
      subjectBreakdown: const [
        SubjectBreakdown(
          name: 'Math',
          minutes: 120,
          percent: 60,
          color: 0xFF8A5CF6,
        ),
        SubjectBreakdown(
          name: 'Science',
          minutes: 80,
          percent: 40,
          color: 0xFF22C55E,
        ),
      ],
      plannedMinutes: 240,
      completedPlannedMinutes: 180,
      activeDays: 5,
      longestStreak: 8,
      insights: const ['Your study rhythm is improving'],
      bestRecords: const [BestRecord(label: 'Best day', value: '2h 30m')],
      recentAchievements: const ['Focused 5 days in a row'],
    );
  }
}

void main() {
  testWidgets('Statistics overview renders and scrolls without layout errors', (
    WidgetTester tester,
  ) async {
    final cubit = StatisticsCubit(repository: _FakeStatisticsRepository());
    cubit.emit(
      StatisticsState.loaded(
        StatisticsSnapshot(
          period: StatisticsPeriod.week,
          subtitle: 'This week',
          studyMinutes: 180,
          sessionCount: 4,
          planCompletionPercent: 75,
          currentStreak: 6,
          goalMinutes: 240,
          chartPoints: const [
            ChartPoint(label: 'M', minutes: 30),
            ChartPoint(label: 'T', minutes: 45),
            ChartPoint(label: 'W', minutes: 55),
            ChartPoint(label: 'T', minutes: 40),
            ChartPoint(label: 'F', minutes: 60),
          ],
          subjectBreakdown: const [
            SubjectBreakdown(
              name: 'Math',
              minutes: 120,
              percent: 60,
              color: 0xFF8A5CF6,
            ),
            SubjectBreakdown(
              name: 'Science',
              minutes: 80,
              percent: 40,
              color: 0xFF22C55E,
            ),
          ],
          plannedMinutes: 240,
          completedPlannedMinutes: 180,
          activeDays: 5,
          longestStreak: 8,
          insights: const ['Your study rhythm is improving'],
          bestRecords: const [BestRecord(label: 'Best day', value: '2h 30m')],
          recentAchievements: const ['Focused 5 days in a row'],
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const StatisticsScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Your Progress'), findsOneWidget);
    expect(find.text('Study Time'), findsWidgets);
    expect(find.text('Current Streak'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

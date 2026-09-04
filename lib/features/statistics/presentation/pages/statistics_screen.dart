import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_planner/core/app_colors.dart';

import 'package:study_planner/core/widgets/application_drawer.dart';

import 'package:study_planner/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_achievement_preview.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_activity_chart.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_best_records.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_empty_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_header.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_heatmap.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_insights.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_loading_state.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_metric_card.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_period_selector.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_plan_progress.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_section_header.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_subject_breakdown.dart';
import 'package:study_planner/features/statistics/presentation/widgets/statistics_subject_donut_chart.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatisticsPeriod _selectedPeriod = StatisticsPeriod.week;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state.status == StatisticsStatus.loading) {
          return const StatisticsLoadingState();
        }

        if (state.status == StatisticsStatus.failure) {
          return StatisticsEmptyState(
            title: l10n.unableToLoadStatistics,
            message: l10n.statisticsLoadError,
          );
        }

        final snapshot = state.snapshot;
        if (snapshot == null || state.status == StatisticsStatus.empty) {
          return Scaffold(
            drawer: ApplicationDrawer(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  children: [
                    StatisticsPeriodSelector(
                      selected: _selectedPeriod,
                      onChanged: (period) {
                        setState(() => _selectedPeriod = period);
                        context.read<StatisticsCubit>().loadStatistics(
                          period: period,
                        );
                      },
                    ),
                    Expanded(
                      child: StatisticsEmptyState(
                        title: l10n.startFirstStreak,
                        message: l10n.completeSessionToUnlock,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (_selectedPeriod != snapshot.period) {
          context.read<StatisticsCubit>().loadStatistics(
            period: _selectedPeriod,
          );
        }

        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                StatisticsHeader(
                  title: l10n.yourProgress,
                  subtitle: _subtitleForPeriod(snapshot.period, l10n),
                  streak: snapshot.currentStreak,
                ),
                const SizedBox(height: 16),
                StatisticsPeriodSelector(
                  selected: _selectedPeriod,
                  onChanged: (period) {
                    setState(() => _selectedPeriod = period);
                    context.read<StatisticsCubit>().loadStatistics(
                      period: period,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppColors.radiusXl),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.18),
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.studyTime,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: context.sfColors.mutedForeground,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatDuration(snapshot.studyMinutes),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.sessionsCompleted(snapshot.sessionCount),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: context.sfColors.mutedForeground,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.sfColors.primaryLight,
                          borderRadius: BorderRadius.circular(
                            AppColors.radiusLg,
                          ),
                        ),
                        child: Icon(
                          Icons.timer_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;

                    final cardHeight = width < 360
                        ? 145.0
                        : width < 600
                        ? 150.0
                        : 158.0;

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisExtent: cardHeight,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: [
                        StatisticsMetricCard(
                          title: l10n.studyTimeMetric,
                          value: _formatDuration(snapshot.studyMinutes),
                          subtitle: l10n.completedSessionsMetric(
                            snapshot.sessionCount,
                          ),
                          icon: Icons.timer_rounded,
                          tint: context.sfColors.chart1,
                        ),

                        StatisticsMetricCard(
                          title: l10n.sessionsMetric,
                          value: '${snapshot.sessionCount}',
                          subtitle: l10n.completed,
                          icon: Icons.check_circle_rounded,
                          tint: context.sfColors.chart2,
                        ),

                        StatisticsMetricCard(
                          title: l10n.planCompletion,
                          value: '${snapshot.planCompletionPercent}%',
                          subtitle: l10n.plannedVsCompleted(
                            _formatDuration(snapshot.completedPlannedMinutes),
                            _formatDuration(snapshot.plannedMinutes),
                          ),
                          icon: Icons.task_alt_rounded,
                          tint: context.sfColors.chart3,
                        ),

                        StatisticsMetricCard(
                          title: l10n.currentStreak,
                          value: '${snapshot.currentStreak}d',
                          subtitle: l10n.activeStreak,
                          icon: Icons.local_fire_department_rounded,
                          tint: context.sfColors.accent,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.studyActivity),
                const SizedBox(height: 10),
                StatisticsActivityChart(
                  chartPoints: snapshot.chartPoints,
                  goalMinutes: snapshot.goalMinutes,
                  period: snapshot.period,
                ),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.studyBySubject),
                const SizedBox(height: 10),
                StatisticsSubjectDonutChart(
                  subjects: snapshot.subjectBreakdown,
                ),
                const SizedBox(height: 12),
                StatisticsSubjectBreakdown(subjects: snapshot.subjectBreakdown),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.plannedVsCompletedHeader),
                const SizedBox(height: 10),
                StatisticsPlanProgress(
                  plannedSeconds: snapshot.plannedMinutes,
                  completedSeconds: snapshot.completedPlannedMinutes,
                ),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.consistency),
                const SizedBox(height: 10),
                StatisticsHeatmap(
                  activeDays: snapshot.activeDays,
                  longestStreak: snapshot.longestStreak,
                ),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.insights),
                const SizedBox(height: 10),
                StatisticsInsights(insights: snapshot.insights),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.bestRecords),
                const SizedBox(height: 10),
                StatisticsBestRecords(records: snapshot.bestRecords),
                const SizedBox(height: 20),
                StatisticsSectionHeader(title: l10n.recentAchievements),
                const SizedBox(height: 10),
                StatisticsAchievementPreview(
                  achievements: snapshot.recentAchievements,
                ),
              ],
            ),
          ),
        );
      },
    );
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

  /// Derives the subtitle string shown under "Your Progress" from the
  /// selected period using the current locale. No hard-coded strings.
  static String _subtitleForPeriod(
    StatisticsPeriod period,
    AppLocalizations l10n,
  ) {
    return switch (period) {
      StatisticsPeriod.today => l10n.periodToday,
      StatisticsPeriod.week => l10n.periodWeek,
      StatisticsPeriod.month => l10n.periodMonth,
      StatisticsPeriod.year => l10n.periodYear,
      StatisticsPeriod.allTime => l10n.periodAllTime,
    };
  }
}

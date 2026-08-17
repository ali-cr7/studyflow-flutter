import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
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

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatisticsPeriod _selectedPeriod = StatisticsPeriod.week;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state.status == StatisticsStatus.loading) {
          return const StatisticsLoadingState();
        }

        if (state.status == StatisticsStatus.failure) {
          return const StatisticsEmptyState(
            title: 'Unable to load statistics',
            message: 'Your study data could not be loaded right now.',
          );
        }

        final snapshot = state.snapshot;
        if (snapshot == null || state.status == StatisticsStatus.empty) {
          return const StatisticsEmptyState(
            title: 'Start your first study streak',
            message:
                'Complete a study session to unlock your progress dashboard.',
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
                  title: 'Your Progress',
                  subtitle: snapshot.subtitle,
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
                              'Study time',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: context.sfColors.mutedForeground,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatMinutes(snapshot.studyMinutes),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${snapshot.sessionCount} sessions completed',
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
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.35,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    StatisticsMetricCard(
                      title: 'Study Time',
                      value: _formatMinutes(snapshot.studyMinutes),
                      subtitle: '${snapshot.sessionCount} completed sessions',
                      icon: Icons.timer_rounded,
                      tint: context.sfColors.chart1,
                    ),
                    StatisticsMetricCard(
                      title: 'Sessions',
                      value: '${snapshot.sessionCount}',
                      subtitle: 'completed',
                      icon: Icons.check_circle_rounded,
                      tint: context.sfColors.chart2,
                    ),
                    StatisticsMetricCard(
                      title: 'Plan Completion',
                      value: '${snapshot.planCompletionPercent}%',
                      subtitle:
                          '${_formatMinutes(snapshot.completedPlannedMinutes)} of ${_formatMinutes(snapshot.plannedMinutes)}',
                      icon: Icons.task_alt_rounded,
                      tint: context.sfColors.chart3,
                    ),
                    StatisticsMetricCard(
                      title: 'Current Streak',
                      value: '${snapshot.currentStreak}d',
                      subtitle: 'active streak',
                      icon: Icons.local_fire_department_rounded,
                      tint: context.sfColors.accent,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Study Activity'),
                const SizedBox(height: 10),
                StatisticsActivityChart(
                  chartPoints: snapshot.chartPoints,
                  goalMinutes: snapshot.goalMinutes,
                ),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Study by Subject'),
                const SizedBox(height: 10),
                StatisticsSubjectBreakdown(subjects: snapshot.subjectBreakdown),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Planned vs Completed'),
                const SizedBox(height: 10),
                StatisticsPlanProgress(
                  plannedMinutes: snapshot.plannedMinutes,
                  completedMinutes: snapshot.completedPlannedMinutes,
                ),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Consistency'),
                const SizedBox(height: 10),
                StatisticsHeatmap(
                  activeDays: snapshot.activeDays,
                  longestStreak: snapshot.longestStreak,
                ),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Insights'),
                const SizedBox(height: 10),
                StatisticsInsights(insights: snapshot.insights),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Best Records'),
                const SizedBox(height: 10),
                StatisticsBestRecords(records: snapshot.bestRecords),
                const SizedBox(height: 20),
                const StatisticsSectionHeader(title: 'Recent Achievements'),
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

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }
}

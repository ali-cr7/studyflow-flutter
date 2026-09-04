import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';
import 'package:study_planner/features/statistics/presentation/cubit/subject_distribution_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class StatisticsSubjectDonutChart extends StatelessWidget {
  const StatisticsSubjectDonutChart({super.key, required this.subjects});

  final List<SubjectBreakdown> subjects;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectDistributionCubit(),
      child: _DonutChartView(subjects: subjects),
    );
  }
}

class _DonutChartView extends StatelessWidget {
  const _DonutChartView({required this.subjects});

  final List<SubjectBreakdown> subjects;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    if (subjects.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(AppColors.radiusXl),
          border: Border.all(color: colors.border, width: 1),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pie_chart_outline,
                size: 48,
                color: colors.mutedForeground,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.subjectDistributionEmpty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // subject.minutes contains duration in SECONDS
    final totalSeconds = subjects.fold<int>(
      0,
      (sum, item) => sum + item.minutes,
    );

    return BlocBuilder<SubjectDistributionCubit, int?>(
      builder: (context, selectedIndex) {
        final selectedSubject = selectedIndex != null
            ? subjects[selectedIndex]
            : null;
        final selectedPercent = selectedSubject != null && totalSeconds > 0
            ? ((selectedSubject.minutes / totalSeconds) * 100).round()
            : 0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(AppColors.radiusXl),
            border: Border.all(color: colors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.subjectDistributionTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 1,
                        centerSpaceRadius: 50,
                        pieTouchData: PieTouchData(
                          enabled: true,
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                                if (event is FlTapUpEvent) {
                                  final touchedSection =
                                      pieTouchResponse?.touchedSection;
                                  if (touchedSection != null) {
                                    final index =
                                        touchedSection.touchedSectionIndex;
                                    // Validate index is within bounds
                                    if (index >= 0 &&
                                        index < subjects.length) {
                                      context
                                          .read<SubjectDistributionCubit>()
                                          .selectSection(index);
                                    } else {
                                      context
                                          .read<SubjectDistributionCubit>()
                                          .clearSelection();
                                    }
                                  } else {
                                    context
                                        .read<SubjectDistributionCubit>()
                                        .clearSelection();
                                  }
                                }
                              },
                        ),
                        sections: _buildPieSections(
                          subjects,
                          totalSeconds,
                          selectedIndex,
                        ),
                      ),
                    ),
                    // Center text showing selected subject or total
                    // IgnorePointer allows touches to pass through to the PieChart
                    IgnorePointer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (selectedSubject != null) ...[
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Color(selectedSubject.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedSubject.name ?? '',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '$selectedPercent%',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: colors.mutedForeground,
                              ),
                            ),
                          ] else ...[
                            Text(
                              l10n.totalStudyTime,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colors.mutedForeground,
                              ),
                            ),
                            Text(
                              _formatDuration(totalSeconds),
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Legend at bottom right - colors only (tappable for small sections)
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: subjects.asMap().entries.map((entry) {
                    final index = entry.key;
                    final subject = entry.value;
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () => context
                          .read<SubjectDistributionCubit>()
                          .selectSection(index),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isSelected ? 14 : 10,
                            height: isSelected ? 14 : 10,
                            decoration: BoxDecoration(
                              color: Color(subject.color),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: theme.colorScheme.primary,
                                      width: 2,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            subject.name ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildPieSections(
    List<SubjectBreakdown> subjects,
    int totalSeconds,
    int? selectedIndex,
  ) {
    return subjects.asMap().entries.map((entry) {
      final index = entry.key;
      final subject = entry.value;
      final percent = totalSeconds == 0
          ? 0.0
          : (subject.minutes / totalSeconds) * 100;
      final isSelected = selectedIndex == index;

      return PieChartSectionData(
        color: Color(subject.color),
        value: percent,
        title: '',
        radius: isSelected ? 65 : 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        borderSide: isSelected
            ? BorderSide(color: Color(subject.color).withOpacity(0.5), width: 3)
            : BorderSide.none,
      );
    }).toList();
  }

  /// The input is duration in seconds.
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
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/history/presentation/cubit/history_cubit.dart';
import 'package:study_planner/features/history/presentation/widgets/history_card.dart';
import 'package:study_planner/features/history/presentation/widgets/history_monthly_selector.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.history)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HistoryMonthSelector(),

              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    if (state is HistoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HistoryError) {
                      return Center(
                        child: Text(
                          l10n.error(state.message),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state is! HistoryLoaded) {
                      return const SizedBox.shrink();
                    }

                    if (state.days.isEmpty) {
                      return _EmptyHistory(month: state.month);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MonthlySummary(state: state),

                        const SizedBox(height: 20),

                        Text(
                          l10n.studyDays,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: state.days.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return HistoryDayCard(day: state.days[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthlySummary extends StatelessWidget {
  const _MonthlySummary({required this.state});

  final HistoryLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppColors.radiusXl),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              value: '${state.totalSessions}',
              label: l10n.sessions,
              icon: Icons.timer_outlined,
            ),
          ),
          Container(width: 1, height: 42, color: colors.border),
          Expanded(
            child: _SummaryItem(
              value: '${state.activeDays}',
              label: l10n.activeDays,
              icon: Icons.calendar_today_outlined,
            ),
          ),
          Container(width: 1, height: 42, color: colors.border),
          Expanded(
            child: _SummaryItem(
              value: HistoryCubit.formatDuration(state.totalSeconds),
              label: l10n.studyTime,
              icon: Icons.schedule_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 34,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              l10n.noStudyHistory,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.noStudyHistoryMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.mutedForeground,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

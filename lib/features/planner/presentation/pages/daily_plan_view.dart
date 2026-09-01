import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/app_drawer.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/widgets/application_drawer.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';
import 'package:study_planner/features/planner/presentation/widgets/daily_plan_add_subject_sheet.dart';
import 'package:study_planner/features/planner/presentation/widgets/daily_plan_empty_state.dart';
import 'package:study_planner/features/planner/presentation/widgets/daily_plan_session_card.dart';
import 'package:study_planner/features/planner/presentation/widgets/daily_plan_summary_card.dart';
import 'package:study_planner/features/session/presentation/pages/session_page.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

class DailyPlanView extends StatelessWidget {
  const DailyPlanView({super.key});

  Future<void> _openAddSheet(BuildContext context) async {
    final cubit = context.read<DailyPlanCubit>();
    final state = cubit.state;

    if (state is! DailyPlanLoaded || state.availableSubjects.isEmpty) {
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: DailyPlanAddSubjectSheet(
            availableSubjects: state.availableSubjects,
            sessionDurationMinutes: state.sessionDurationMinutes,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      drawer: ApplicationDrawer(),
      appBar: AppBar(
        title: Text(l10n.dailyPlanTitle),
        actions: [
          IconButton(
            onPressed: () => context.go(AppRoutes.subjects),
            icon: const Icon(Icons.school_outlined),
            tooltip: l10n.subjects,
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<DailyPlanCubit, DailyPlanState>(
        builder: (context, state) {
          if (state is! DailyPlanLoaded || state.availableSubjects.isEmpty) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton.extended(
            heroTag: 'add_daily_plan_subject',
            onPressed: () => _openAddSheet(context),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.addSubject),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
          child: BlocBuilder<DailyPlanCubit, DailyPlanState>(
            builder: (context, state) {
              if (state is DailyPlanLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DailyPlanError) {
                return Center(child: Text(l10n.error(state.message)));
              }

              if (state is! DailyPlanLoaded) {
                return Center(child: Text(l10n.loadingYourPlan));
              }

              final plan = state.plan;
              final displayItems = <_DailyPlanDisplayItem>[];
              for (final plannedSubject in plan.subjects) {
                final subject = state.subjectsById[plannedSubject.subjectId];
                if (subject == null) continue;

                final sessionCount =
                    ((plannedSubject.plannedMinutes /
                                state.sessionDurationMinutes)
                            .round())
                        .clamp(1, 12);

                for (var index = 0; index < sessionCount; index++) {
                  displayItems.add(
                    _DailyPlanDisplayItem(
                      plannedSubject: plannedSubject,
                      subject: subject,
                      sessionNumber: index + 1,
                      totalSessions: sessionCount,
                    ),
                  );
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DailyPlanSummaryCard(
                    date: state.date,
                    totalPlannedMinutes: plan.totalPlannedMinutes,
                    completedPlannedMinutes: plan.completedPlannedMinutes,
                  ),
                  const SizedBox(height: 22),
                  Text(l10n.todaysSchedule, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 14),
                  if (plan.subjects.isEmpty)
                    const Expanded(child: DailyPlanEmptyState())
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: displayItems.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = displayItems[index];
                          return DailyPlanSessionCard(
                            plannedSubject: item.plannedSubject,
                            subject: item.subject,
                            sessionNumber: item.sessionNumber,
                            totalSessions: item.totalSessions,
                            onTap: () {
                              context.push(
                                AppRoutes.session,
                                extra: SessionRouteArgs(
                                  subject: item.subject,
                                  plannedMinutes:
                                      item.plannedSubject.plannedMinutes,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DailyPlanDisplayItem {
  const _DailyPlanDisplayItem({
    required this.plannedSubject,
    required this.subject,
    required this.sessionNumber,
    required this.totalSessions,
  });

  final PlannedSubject plannedSubject;
  final Subject subject;
  final int sessionNumber;
  final int totalSessions;
}

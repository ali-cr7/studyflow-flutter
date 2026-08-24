import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/app_drawer.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';
import 'package:study_planner/features/planner/presentation/widgets/subject_card.dart';
import 'package:study_planner/features/planner/presentation/widgets/subject_form_sheet.dart';
import 'package:study_planner/features/planner/presentation/widgets/subjects_empty_state.dart';
import 'package:study_planner/features/planner/presentation/widgets/subjects_header.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  Future<void> _openEditor(BuildContext context, [Subject? subject]) async {
    final cubit = context.read<SubjectsCubit>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (modalContext) {
        return SubjectFormSheet(
          subject: subject,
          onSaved: (savedSubject) async {
            await cubit.saveSubject(savedSubject);
          },
        );
      },
    );
  }

  Future<void> _deleteSubject(BuildContext context, Subject subject) async {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SubjectsCubit>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete subject?'),
        content: Text('Remove ${subject.name} from your subject list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await cubit.deleteSubject(subject.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: AppDrawer(
        onRecordsTap: () {
          // Navigate to Records
          // Navigator.of(context).pop();
          context.push(AppRoutes.achievements);
        },
        onHistoryTap: () {
          context.push(AppRoutes.history);
        },
        onAskTeacherTap: () {
          final dashboardState = context.read<DashboardCubit>().state;
          final subjectsState = context.read<SubjectsCubit>().state;

          if (dashboardState.profile == null) {
            return;
          }

          if (subjectsState is! SubjectsLoaded) {
            return;
          }

          context.push(
            AppRoutes.askTeacher,
            extra: AskTeacherRouteArgs(
              studentName: dashboardState.profile!.name,
              subjects: subjectsState.subjects,
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Subjects'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.dailyPlan),
            icon: const Icon(Icons.calendar_today_outlined),
            label: const Text('Daily plan'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_subject',
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add subject'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SubjectsCubit, SubjectsState>(
                builder: (context, state) {
                  final subjectCount = state is SubjectsLoaded
                      ? state.subjects.length
                      : 0;
                  return SubjectsHeader(subjectCount: subjectCount);
                },
              ),
              const SizedBox(height: 24),
              Text('Your subjects', style: theme.textTheme.titleLarge),
              const SizedBox(height: 14),
              Expanded(
                child: BlocBuilder<SubjectsCubit, SubjectsState>(
                  builder: (context, state) {
                    if (state is SubjectsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SubjectsError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }

                    final subjects = state is SubjectsLoaded
                        ? state.subjects
                        : <Subject>[];

                    if (subjects.isEmpty) {
                      return const SubjectsEmptyState();
                    }

                    return ListView.separated(
                      itemCount: subjects.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final subject = subjects[index];

                        return SubjectCard(
                          subject: subject,
                          onEdit: () => _openEditor(context, subject),
                          onDelete: () => _deleteSubject(context, subject),
                        );
                      },
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

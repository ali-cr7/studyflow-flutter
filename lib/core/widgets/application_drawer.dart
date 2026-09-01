import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:study_planner/app_drawer.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';

class ApplicationDrawer extends StatelessWidget {
  const ApplicationDrawer({super.key});

  Future<void> _openAskTeacher(BuildContext context) async {
    final dashboardState = context.read<DashboardCubit>().state;
    final subjectsCubit = context.read<SubjectsCubit>();

    // Wait until SubjectsCubit finishes loading.
    if (subjectsCubit.state is SubjectsLoading) {
      await subjectsCubit.stream.firstWhere(
        (state) =>
            state is SubjectsLoaded ||
            state is SubjectsError,
      );
    }

    if (!context.mounted) return;

    final subjectsState = subjectsCubit.state;

    if (subjectsState is! SubjectsLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to load subjects. Please try again.'),
        ),
      );
      return;
    }

    final studentName = dashboardState.profile?.name ?? '';

    if (studentName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student profile is not available.'),
        ),
      );
      return;
    }

    // Close the drawer.
 //   Navigator.of(context).pop();

    // Give the drawer time to close.
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    if (!context.mounted) return;

    context.push(
      AppRoutes.askTeacher,
      extra: AskTeacherRouteArgs(
        studentName: studentName,
        subjects: subjectsState.subjects,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      onRecordsTap: () {
       
        context.push(AppRoutes.achievements);
      },

      onHistoryTap: () {
     
        context.push(AppRoutes.history);
      },

      onAskTeacherTap: () {
        _openAskTeacher(context);
      },
    );
  }
}
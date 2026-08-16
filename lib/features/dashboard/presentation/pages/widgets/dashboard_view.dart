import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_content.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return switch (state.status) {
          DashboardStatus.loading => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          DashboardStatus.failure => Scaffold(
            body: Center(
              child: Text(state.errorMessage ?? 'Something went wrong.'),
            ),
          ),
          DashboardStatus.empty => const Scaffold(
            body: Center(child: Text('No profile found.')),
          ),
          DashboardStatus.loaded => DashboardContent(state: state),
        };
      },
    );
  }
}

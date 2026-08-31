import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_content.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return switch (state.status) {
          DashboardStatus.loading => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          DashboardStatus.failure => Scaffold(
            body: Center(
              child: Text(state.errorMessage ?? l10n.errorOccurred),
            ),
          ),
          DashboardStatus.empty => Scaffold(
            body: Center(child: Text(l10n.noProfileFound)),
          ),
          DashboardStatus.loaded => DashboardContent(state: state),
        };
      },
    );
  }
}

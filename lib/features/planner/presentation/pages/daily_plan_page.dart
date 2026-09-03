import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_view.dart';

class DailyPlanPage extends StatefulWidget {
  const DailyPlanPage({
    super.key,
    required this.tabIndexNotifier,
    required this.refreshNotifier,
  });

  final ValueNotifier<int> tabIndexNotifier;
  final ValueNotifier<int> refreshNotifier;

  @override
  State<DailyPlanPage> createState() => _DailyPlanPageState();
}

class _DailyPlanPageState extends State<DailyPlanPage> {
  @override
  void initState() {
    super.initState();
    widget.tabIndexNotifier.addListener(_onTabChanged);
    widget.refreshNotifier.addListener(_onRefreshRequested);
  }

  @override
  void dispose() {
    widget.tabIndexNotifier.removeListener(_onTabChanged);
    widget.refreshNotifier.removeListener(_onRefreshRequested);
    super.dispose();
  }

  void _onTabChanged() {
    if (widget.tabIndexNotifier.value == 1) {
      context.read<DailyPlanCubit>().refresh();
    }
  }

  void _onRefreshRequested() {
    if (widget.tabIndexNotifier.value == 1) {
      context.read<DailyPlanCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const DailyPlanView();
  }
}
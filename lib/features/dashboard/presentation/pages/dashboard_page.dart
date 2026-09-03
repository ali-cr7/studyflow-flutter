import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.tabIndexNotifier,
    required this.refreshNotifier,
  });

  final ValueNotifier<int> tabIndexNotifier;
  final ValueNotifier<int> refreshNotifier;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
    if (widget.tabIndexNotifier.value == 0) {
      context.read<DashboardCubit>().refresh();
    }
  }

  void _onRefreshRequested() {
    if (widget.tabIndexNotifier.value == 0) {
      context.read<DashboardCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardView();
  }
}
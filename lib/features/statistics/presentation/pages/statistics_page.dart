import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:study_planner/features/statistics/presentation/pages/statistics_screen.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({
    super.key,
    required this.tabIndexNotifier,
    required this.refreshNotifier,
  });

  final ValueNotifier<int> tabIndexNotifier;
  final ValueNotifier<int> refreshNotifier;

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
    if (widget.tabIndexNotifier.value == 4) {
      context.read<StatisticsCubit>().refresh();
    }
  }

  void _onRefreshRequested() {
    if (widget.tabIndexNotifier.value == 4) {
      context.read<StatisticsCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const StatisticsScreen();
  }
}
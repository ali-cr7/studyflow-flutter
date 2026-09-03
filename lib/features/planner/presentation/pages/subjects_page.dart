import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';
import 'package:study_planner/features/planner/presentation/widgets/subjects_view.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({
    super.key,
    required this.tabIndexNotifier,
    required this.refreshNotifier,
  });

  final ValueNotifier<int> tabIndexNotifier;
  final ValueNotifier<int> refreshNotifier;

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
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
    if (widget.tabIndexNotifier.value == 3) {
      context.read<SubjectsCubit>().refresh();
    }
  }

  void _onRefreshRequested() {
    if (widget.tabIndexNotifier.value == 3) {
      context.read<SubjectsCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SubjectsView();
  }
}
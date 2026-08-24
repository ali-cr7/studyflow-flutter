import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/history/presentation/cubit/history_cubit.dart';
import 'package:study_planner/features/history/presentation/views/history_view.dart';

import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';
import 'package:get_it/get_it.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryCubit(
        studySessionRepository: GetIt.I<StudySessionRepository>(),
        subjectRepository: GetIt.I<SubjectRepository>(),
      )..loadCurrentMonth(),
      child: const HistoryView(),
    );
  }
}

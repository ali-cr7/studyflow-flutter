import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/ask_teacher/presentation/cubit/ask_teacher_cubit.dart';
import 'package:study_planner/features/ask_teacher/presentation/screens/ask_teacher_view.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

class AskTeacherScreen extends StatelessWidget {
  const AskTeacherScreen({
    super.key,
    required this.studentName,
    required this.subjects,
  });

  final String studentName;
  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AskTeacherCubit(
        studentName: studentName,
        subjects: subjects,
      ),
      child: const AskTeacherView(),
    );
  }
}


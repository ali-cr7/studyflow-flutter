import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_view.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class DailyPlanPage extends StatelessWidget {
  const DailyPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DailyPlanCubit(
        dailyPlanRepository: getIt<DailyPlanRepository>(),
        subjectRepository: getIt<SubjectRepository>(),
        profileRepository: getIt<StudentProfileRepository>(),
      )..loadPlanForDate(DateTime.now()),
      child: const DailyPlanView(),
    );
  }
}

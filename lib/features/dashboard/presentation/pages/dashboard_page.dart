import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/pages/widgets/dashboard_view.dart';
import 'package:study_planner/features/planner/cubit/subjects_cubit.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DashboardCubit(
            profileRepository: getIt<StudentProfileRepository>(),
            settingsRepository: getIt<AppSettingsRepository>(),
          )..loadDashboard(),
        ),
         BlocProvider<SubjectsCubit>(
          create: (_) =>
              SubjectsCubit(getIt<SubjectRepository>())..loadSubjects(),
        ),
      ],
      child: DashboardView(),
    );

    // BlocProvider(
    //   create: (_) => DashboardCubit(
    //     profileRepository: getIt<StudentProfileRepository>(),
    //     settingsRepository: getIt<AppSettingsRepository>(),
    //   )..loadDashboard(),
    //   child: DashboardView(),
    // );
  }
}

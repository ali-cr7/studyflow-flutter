import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/activation/cubit/activation_cubit.dart';
import 'package:study_planner/features/activation/presentation/widgets/acivation_view.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry-point widget — provides the cubit then renders the view.
// ─────────────────────────────────────────────────────────────────────────────

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivationCubit(
        licenseRepository: getIt<LicenseRepository>(),
      ),
      child: const ActivationView(),
    );
  }
}








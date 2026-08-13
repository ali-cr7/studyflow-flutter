import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/di/injection.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/features/onboarding/presentation/pages/page_body.dart';
import 'package:study_planner/features/onboarding/presentation/widgets/stepper_indicator.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(
        profileRepository: getIt<StudentProfileRepository>(),
        settingsRepository: getIt<AppSettingsRepository>(),
      ),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.go(AppRoutes.dashboard);
        }
        if (state.status == OnboardingStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          final colors = context.sfColors;
          final scheme = theme.colorScheme;
          final cubit = context.read<OnboardingCubit>();
          final isSubmitting = state.status == OnboardingStatus.submitting;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Onboarding'),
              actions: [
                if (state.pageIndex < OnboardingState.totalPages - 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Center(
                      child: Text(
                        'Step ${state.pageIndex + 1} of ${OnboardingState.totalPages}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    StepperIndicator(currentIndex: state.pageIndex),
                    const SizedBox(height: 24),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: PageBody(
                          key: ValueKey(state.pageIndex),
                          pageIndex: state.pageIndex,
                          theme: theme,
                          scheme: scheme,
                          colors: colors,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Row(
                  children: [
                    if (state.pageIndex > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isSubmitting ? null : cubit.goBack,
                          child: const Text('Back'),
                        ),
                      ),
                    if (state.pageIndex > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed:
                            state.canContinue && !isSubmitting ? cubit.goNext : null,
                        child: isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(
                                state.pageIndex == OnboardingState.totalPages - 1
                                    ? 'Start Studying'
                                    : 'Next',
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

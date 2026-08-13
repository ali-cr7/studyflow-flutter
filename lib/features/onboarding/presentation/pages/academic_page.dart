import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';

class AcademicPage extends StatelessWidget {
  const AcademicPage({
    super.key,
    required this.theme,
    required this.scheme,
    required this.colors,
  });

  final ThemeData theme;
  final ColorScheme scheme;
  final StudyFlowColors colors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return SingleChildScrollView(
          key: const ValueKey('academic'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Academic information',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Grade',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: state.grade,
                items: OnboardingState.gradeOptions
                    .map(
                      (grade) =>
                          DropdownMenuItem(value: grade, child: Text(grade)),
                    )
                    .toList(),
                onChanged: cubit.updateGrade,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Later, you can tailor subjects or study plans based on this.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 30),
              if (state.grade != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppColors.radiusLg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Icon(Icons.school, color: scheme.primary),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'You selected ${state.grade}. We’ll keep that in mind when suggesting study routines.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

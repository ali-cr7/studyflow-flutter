import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/features/onboarding/presentation/pages/option_pill.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({
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
          key: const ValueKey('preferences'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferred focus session',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final minutes in OnboardingState.studySessionOptions)
                    OptionPill(
                      label: '$minutes min',
                      selected: !state.customStudySelected &&
                          state.selectedStudyMinutes == minutes,
                      onTap: () => cubit.selectStudyMinutes(minutes),
                    ),
                  OptionPill(
                    label: 'Custom',
                    selected: state.customStudySelected,
                    onTap: cubit.enableCustomStudyMinutes,
                  ),
                ],
              ),
              if (state.customStudySelected) ...[
                const SizedBox(height: 18),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Session length (minutes)',
                    hintText: '60',
                  ),
                  onChanged: cubit.updateCustomStudyMinutes,
                ),
              ],
              const SizedBox(height: 24),
              Text('Break duration', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final minutes in OnboardingState.breakOptions)
                    OptionPill(
                      label: '$minutes min',
                      selected: state.selectedBreakMinutes == minutes,
                      onTap: () => cubit.selectBreakMinutes(minutes),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'These become the default Pomodoro settings.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

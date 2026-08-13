import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/features/onboarding/presentation/pages/option_pill.dart';
import 'package:study_planner/features/onboarding/presentation/pages/summary_stat.dart';

class StudyGoalPage extends StatelessWidget {
  const StudyGoalPage({
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
          key: const ValueKey('studyGoal'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How much do you want to study each day?',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final minutes in OnboardingState.dailyGoalOptions)
                    OptionPill(
                      label: '${minutes ~/ 60} hour${minutes == 60 ? '' : 's'}',
                      selected: !state.customDailyGoalSelected &&
                          state.selectedDailyGoalMinutes == minutes,
                      onTap: () => cubit.selectDailyGoal(minutes),
                    ),
                  OptionPill(
                    label: 'Custom',
                    selected: state.customDailyGoalSelected,
                    onTap: cubit.enableCustomDailyGoal,
                  ),
                ],
              ),
              if (state.customDailyGoalSelected) ...[
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Hours',
                          hintText: '2',
                        ),
                        onChanged: cubit.updateCustomDailyGoalHours,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Minutes',
                          hintText: '30',
                        ),
                        onChanged: cubit.updateCustomDailyGoalMinutesPart,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              Text(
                'This becomes the daily progress target.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 24),
              SummaryStat(
                label: 'Today’s Goal',
                value: state.dailyGoalLabel,
                icon: Icons.flag_outlined,
                color: scheme.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/features/onboarding/presentation/pages/review_tile.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({
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
        final name = state.name.trim().isEmpty ? 'Student' : state.name.trim();
        final grade = state.grade ?? 'Other';

        return SingleChildScrollView(
          key: const ValueKey('summary'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '🎉 You\'re all set!',
                  style: theme.textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Review what we’ll save for your study dashboard.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 28),
              ReviewTile(label: 'Name', value: name),
              ReviewTile(label: 'Grade', value: grade),
              ReviewTile(label: 'Daily Goal', value: state.dailyGoalLabel),
              ReviewTile(label: 'Study Session', value: state.studySessionLabel),
              ReviewTile(label: 'Reminder', value: state.reminderLabel),
              const SizedBox(height: 32),
              Text(
                'Tap the button below to jump into your dashboard and start studying.',
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

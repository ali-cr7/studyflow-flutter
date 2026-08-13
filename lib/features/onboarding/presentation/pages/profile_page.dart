import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
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
        final trimmedName = state.name.trim();

        return SingleChildScrollView(
          key: const ValueKey('profile'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '👤 What should we call you?',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Your name',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: state.name,
                onChanged: cubit.updateName,
                decoration: InputDecoration(
                  hintText: 'Ali',
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'This lets you personalize the app.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 22),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppColors.radiusLg),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.16),
                          borderRadius:
                              BorderRadius.circular(AppColors.radiusLg),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: scheme.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          trimmedName.isNotEmpty
                              ? 'Good morning, $trimmedName 👋'
                              : 'Good morning, my friend 👋',
                          style: theme.textTheme.titleMedium,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
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
          key: const ValueKey('notifications'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Would you like daily reminders?',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: scheme.primary,
                activeTrackColor: scheme.primary.withValues(alpha: 0.24),
                title: const Text('Daily Reminder'),
                value: state.notificationEnabled,
                onChanged: cubit.toggleNotifications,
              ),
              const SizedBox(height: 16),
              Text('Choose time', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: state.notificationEnabled
                    ? () => _pickNotificationTime(context, cubit, state)
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: state.notificationEnabled
                      ? scheme.primary
                      : colors.muted,
                  foregroundColor: state.notificationEnabled
                      ? scheme.onPrimary
                      : colors.mutedForeground,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(state.reminderLabel),
              ),
              const SizedBox(height: 24),
              Text(
                'If you skip this, the app still works perfectly.',
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

  Future<void> _pickNotificationTime(
    BuildContext context,
    OnboardingCubit cubit,
    OnboardingState state,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: state.notificationTime,
    );
    if (time != null) {
      cubit.updateNotificationTime(time);
    }
  }
}

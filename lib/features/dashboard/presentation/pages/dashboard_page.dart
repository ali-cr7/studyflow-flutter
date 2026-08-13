import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/di/injection.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(
        profileRepository: getIt<StudentProfileRepository>(),
        settingsRepository: getIt<AppSettingsRepository>(),
      )..loadDashboard(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return switch (state.status) {
          DashboardStatus.loading => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          DashboardStatus.failure => Scaffold(
              body: Center(
                child: Text(state.errorMessage ?? 'Something went wrong.'),
              ),
            ),
          DashboardStatus.empty => const Scaffold(
              body: Center(child: Text('No profile found.')),
            ),
          DashboardStatus.loaded => _DashboardContent(state: state),
        };
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final profile = state.profile!;
    final settings = state.settings!;
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, ${profile.name}',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Ready to reach your study goals today?',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.radiusLg),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Study plan summary',
                        style: theme.textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _DashboardRow(label: 'Grade', value: profile.grade),
                    const SizedBox(height: 10),
                    _DashboardRow(
                      label: 'Daily goal',
                      value: _formatMinutes(profile.dailyGoalMinutes),
                    ),
                    const SizedBox(height: 10),
                    _DashboardRow(
                      label: 'Session length',
                      value: '${profile.preferredSessionDuration} min',
                    ),
                    const SizedBox(height: 10),
                    _DashboardRow(
                      label: 'Break duration',
                      value: '${settings.breakDuration} min',
                    ),
                    const SizedBox(height: 10),
                    _DashboardRow(
                      label: 'Wake up',
                      value: _formatDayTime(profile.wakeUpTime),
                    ),
                    const SizedBox(height: 10),
                    _DashboardRow(
                      label: 'Sleep',
                      value: _formatDayTime(profile.sleepTime),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.primaryLight,
                  borderRadius: BorderRadius.circular(AppColors.radiusLg),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today’s focus', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Text(
                      'Focus for ${settings.studyDuration} minutes, then take ${settings.breakDuration} minutes to recharge.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.primaryDark,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Icon(
                        Icons.bookmark_outline,
                        size: 88,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }

  static String _formatDayTime(DayTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _DashboardRow extends StatelessWidget {
  const _DashboardRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.mutedForeground,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

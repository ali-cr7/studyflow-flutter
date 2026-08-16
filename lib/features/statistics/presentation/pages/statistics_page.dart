import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    final stats = [
      _StatCard(
        title: 'Study streak',
        value: '12 days',
        subtitle: 'You are on a roll',
      ),
      _StatCard(title: 'Focus time', value: '14h 20m', subtitle: 'This week'),
      _StatCard(
        title: 'Best subject',
        value: 'Math',
        subtitle: '84% consistency',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your progress', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.primaryLight,
                  borderRadius: BorderRadius.circular(AppColors.radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This month',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '18 sessions completed',
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '+4 sessions vs last month',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: stats.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => stats[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.trending_up_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(value, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

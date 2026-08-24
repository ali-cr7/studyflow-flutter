import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class HistorySummaryCard extends StatelessWidget {
  const HistorySummaryCard({
    super.key,
    required this.totalSessions,
    required this.totalMinutes,
  });

  final int totalSessions;
  final int totalMinutes;

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0 && remainingMinutes > 0) {
      return '${hours}h ${remainingMinutes}m';
    }

    if (hours > 0) {
      return '${hours}h';
    }

    return '${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          AppColors.radiusXl,
        ),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(
            alpha: 0.15,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Stat(
              icon: Icons.timer_outlined,
              label: 'Study time',
              value: _formatDuration(totalMinutes),
            ),
          ),
          Container(
            width: 1,
            height: 42,
            color: colors.border,
          ),
          Expanded(
            child: _Stat(
              icon: Icons.menu_book_outlined,
              label: 'Sessions',
              value: '$totalSessions',
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
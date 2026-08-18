import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class StatisticsMetricCard extends StatelessWidget {
  const StatisticsMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.tint,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(color: colors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: tint, size: 18),
                ),
              ),
            ],
          ),
          //    const SizedBox(height: 14),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          //  const SizedBox(height: 4),
          Expanded(
            child: Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.mutedForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < 170;

        final padding = isCompact ? 10.0 : 14.0;
        final iconContainerSize = isCompact ? 30.0 : 34.0;
        final iconSize = isCompact ? 16.0 : 18.0;

        return Container(
          padding: EdgeInsets.all(padding),
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style:
                          (isCompact
                                  ? theme.textTheme.labelMedium
                                  : theme.textTheme.labelLarge)
                              ?.copyWith(color: colors.mutedForeground),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: iconContainerSize,
                    height: iconContainerSize,
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(isCompact ? 10 : 12),
                    ),
                    child: Icon(icon, color: tint, size: iconSize),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Main value: never truncate.
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    maxLines: 1,
                    softWrap: false,
                    style:
                        (isCompact
                                ? theme.textTheme.titleLarge
                                : theme.textTheme.headlineSmall)
                            ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 3),

              // Subtitle can wrap instead of showing "..."
              Flexible(
                child: Text(
                  subtitle,
                  style:
                      (isCompact
                              ? theme.textTheme.labelSmall
                              : theme.textTheme.bodySmall)
                          ?.copyWith(color: colors.mutedForeground),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

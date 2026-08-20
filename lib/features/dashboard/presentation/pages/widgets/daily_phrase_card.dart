import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/dashboard/data/daily_phrases.dart';

/// Displays the personalised encouraging phrase of the day.
///
/// The phrase is chosen by day-of-year index from [DailyPhrases], with
/// occurrences of `{name}` replaced by the student's stored name.
class DailyPhraseCard extends StatelessWidget {
  const DailyPhraseCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final phrase = DailyPhrases.forToday(name);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.12),
            theme.colorScheme.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.18),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote icon accent
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.format_quote_rounded,
              size: 28,
              color: theme.colorScheme.primary.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phrase,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.primaryDark,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _dayLabel(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary.withValues(alpha: 0.65),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// e.g. "Phrase 42 of 365 · Feb 11"
  static String _dayLabel() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final dayOfYear = now.difference(startOfYear).inDays + 1;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = months[now.month - 1];
    return 'Phrase $dayOfYear  ·  $month ${now.day}';
  }
}

import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/onboarding/presentation/pages/illustration_card.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
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
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      key: const ValueKey('welcome'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(34),
              ),
              child: const Icon(
                Icons.school_outlined,
                size: 64,
                color: Color(0xFF4C6FFF),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(l10n.onboardingAppName, style: theme.textTheme.displayMedium),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingTagline,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            l10n.onboardingWelcomeMessage,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 32),
          IllustrationCard(colors: colors),
          const SizedBox(height: 32),
          Center(
            child: Text(
              l10n.onboardingGetStartedMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

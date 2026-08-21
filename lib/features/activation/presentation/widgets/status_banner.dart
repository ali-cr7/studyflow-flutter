import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/activation/cubit/activation_cubit.dart';
 // ─────────────────────────────────────────────────────────────────────────────
// Status banner — shown between the input and the button.
// ─────────────────────────────────────────────────────────────────────────────

class StatusBanner extends StatelessWidget {
  const StatusBanner({required this.state, required this.cubit});

  final ActivationState state;
  final ActivationCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    final (message, icon, bg, fg) = switch (state.status) {
      ActivationStatus.idle || ActivationStatus.submitting => (
          null,
          null,
          Colors.transparent,
          Colors.transparent,
        ),
      ActivationStatus.success => (
          'Activation successful! Opening your app…',
          Icons.check_circle_rounded,
          colors.successLight,
          colors.successDark,
        ),
      ActivationStatus.invalidFormat ||
      ActivationStatus.invalidCode =>
        (
          'Invalid activation code. Please check the code and try again.',
          Icons.error_rounded,
          theme.colorScheme.error.withValues(alpha: 0.1),
          theme.colorScheme.error,
        ),
      ActivationStatus.alreadyUsed => (
          'This code has already been used. Please contact your teacher for '
              'a new code.',
          Icons.block_rounded,
          theme.colorScheme.error.withValues(alpha: 0.1),
          theme.colorScheme.error,
        ),
      ActivationStatus.noInternet => (
          'No internet connection. An internet connection is required for '
              'first-time activation.',
          Icons.wifi_off_rounded,
          colors.warningLight,
          colors.warning,
        ),
      ActivationStatus.serverError => (
          'Activation service is temporarily unavailable. '
              'Please try again in a few moments.',
          Icons.cloud_off_rounded,
          colors.warningLight,
          colors.warning,
        ),
      ActivationStatus.partialFailure => (
          'Your code was accepted, but the app could not save the activation '
              'locally. Tap "Retry saving activation" below.',
          Icons.warning_amber_rounded,
          colors.warningLight,
          colors.warning,
        ),
    };

    if (message == null) return const SizedBox.shrink();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(state.status),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          border: Border.all(color: fg.withValues(alpha: 0.35)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: fg),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: fg,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
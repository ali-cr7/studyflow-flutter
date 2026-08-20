import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/activation/cubit/activation_cubit.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry-point widget — provides the cubit then renders the view.
// ─────────────────────────────────────────────────────────────────────────────

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivationCubit(
        licenseRepository: getIt<LicenseRepository>(),
      ),
      child: const _ActivationView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// View
// ─────────────────────────────────────────────────────────────────────────────

class _ActivationView extends StatefulWidget {
  const _ActivationView();

  @override
  State<_ActivationView> createState() => _ActivationViewState();
}

class _ActivationViewState extends State<_ActivationView> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final scheme = theme.colorScheme;

    return BlocConsumer<ActivationCubit, ActivationState>(
      // Navigate to dashboard only once, when status first becomes success.
      listenWhen: (prev, curr) =>
          prev.status != curr.status &&
          curr.status == ActivationStatus.success,
      listener: (context, state) {
        context.go(AppRoutes.dashboard);
      },
      builder: (context, state) {
        final cubit = context.read<ActivationCubit>();

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Branding ──────────────────────────────────────────
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(AppColors.radiusXl),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 44,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Title ─────────────────────────────────────────────
                  Text(
                    'Activate Study Planner',
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enter the activation code provided by your teacher to '
                    'start using Study Planner.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.mutedForeground,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Code input ────────────────────────────────────────
                  Text(
                    'Activation code',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: !state.isSubmitting,
                    // Format hint: SP-XXXX-XXXX
                    inputFormatters: [
                      _ActivationCodeFormatter(),
                    ],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.visiblePassword,
                    style: theme.textTheme.titleMedium?.copyWith(
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'SP-XXXX-XXXX',
                      hintStyle: theme.textTheme.titleMedium?.copyWith(
                        letterSpacing: 2.5,
                        color: colors.mutedForeground,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: state.codeInput.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _controller.clear();
                                cubit.updateCode('');
                              },
                            )
                          : null,
                    ),
                    onChanged: cubit.updateCode,
                    onFieldSubmitted: (_) {
                      if (state.canSubmit) cubit.activate();
                    },
                  ),

                  // ── Status message ────────────────────────────────────
                  const SizedBox(height: 16),
                  _StatusBanner(state: state, cubit: cubit),

                  const SizedBox(height: 32),

                  // ── Activate button ───────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed:
                          state.canSubmit ? () => cubit.activate() : null,
                      child: state.isSubmitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Activate'),
                    ),
                  ),

                  // ── Partial-failure recovery button ───────────────────
                  if (state.isRecoverable) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: cubit.recoverPartialActivation,
                        child: const Text('Retry saving activation'),
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),

                  // ── Footer note ───────────────────────────────────────
                  Center(
                    child: Text(
                      'Each code can only be used once.\n'
                      'An internet connection is required for activation only.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.mutedForeground,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status banner — shown between the input and the button.
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.state, required this.cubit});

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

// ─────────────────────────────────────────────────────────────────────────────
// Input formatter — auto-inserts dashes as the user types:
//   7  →  7
//   7K4M  →  7K4M
//   7K4MX  →  7K4M-X
//   SP7K4MX92P  →  SP-7K4M-X92P
// Strips non-alphanumeric characters and limits to 10 code chars + 2 dashes.
// ─────────────────────────────────────────────────────────────────────────────

class _ActivationCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Strip everything except letters and digits, uppercase.
    final raw =
        newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

    // Limit to 10 meaningful characters (SP + 4 + 4).
    final clipped = raw.length > 10 ? raw.substring(0, 10) : raw;

    // Rebuild with dashes: SP-XXXX-XXXX
    final buffer = StringBuffer();
    for (var i = 0; i < clipped.length; i++) {
      if (i == 2 || i == 6) buffer.write('-');
      buffer.write(clipped[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

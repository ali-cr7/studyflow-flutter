import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/routes/app_router.dart';
import 'package:study_planner/features/activation/cubit/activation_cubit.dart';
import 'package:study_planner/features/activation/presentation/widgets/activation_code_formatter.dart';
import 'package:study_planner/features/activation/presentation/widgets/status_banner.dart';

class ActivationView extends StatefulWidget {
  const ActivationView({super.key});

  @override
  State<ActivationView> createState() => ActivationViewState();
}

class ActivationViewState extends State<ActivationView> {
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
                      ActivationCodeFormatter(),
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
                  StatusBanner(state: state, cubit: cubit),

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
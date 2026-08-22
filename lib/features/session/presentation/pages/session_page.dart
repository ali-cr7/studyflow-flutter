import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/core/services/sound_service.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/features/session/cubit/session_cubit.dart';
import 'package:study_planner/features/session/presentation/widgets/celebration_card.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';

class SessionRouteArgs {
  const SessionRouteArgs({required this.subject, required this.plannedMinutes});

  final Subject subject;
  final int plannedMinutes;
}

class SessionPage extends StatelessWidget {
  const SessionPage({
    super.key,
    required this.subject,
    required this.plannedMinutes,
  });

  final Subject subject;
  final int plannedMinutes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionCubit(
        timerService: getIt<StudyTimerService>(),
        settingsRepository: getIt<AppSettingsRepository>(),
        soundService: getIt<SoundService>(),
        subject: subject,
        plannedMinutes: plannedMinutes,
      )..restoreOrStartSession(),
      child: const SessionView(),
    );
  }
}

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> with WidgetsBindingObserver {
  late final SessionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SessionCubit>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_cubit.saveCurrentProgress());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      unawaited(_cubit.saveCurrentProgress());
    } else if (state == AppLifecycleState.resumed) {
      unawaited(_cubit.restoreOrStartSession());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        if (state is SessionBreakActive && state.hasCelebration) {
          CelebrationCard.show(
            context,
            reason: state.celebrationReason,
            subjectName: state.subject.name,
          );
        }
      },
      builder: (context, state) {
        if (state is SessionError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Study session')),
            body: Center(child: Text('Error: ${state.message}')),
          );
        }

        final active = state is SessionActive ? state : null;
        final paused = state is SessionPaused ? state : null;
        final breakActive = state is SessionBreakActive ? state : null;
        final breakComplete = state is SessionBreakComplete ? state : null;

        final subject =
            active?.subject ??
            paused?.subject ??
            breakActive?.subject ??
            breakComplete?.subject ??
            const Subject(
              id: 0,
              name: 'Study session',
              color: 0xFF4C6FFF,
              icon: 'book',
            );

        final totalSeconds =
            active?.totalSeconds ??
            paused?.totalSeconds ??
            breakActive?.totalSeconds ??
            breakComplete?.totalSeconds ??
            0;
        final remainingSeconds =
            active?.remainingSeconds ??
            paused?.remainingSeconds ??
            breakActive?.remainingSeconds ??
            0;

        final timerLabel = active != null
            ? active.formattedRemainingTime
            : paused != null
            ? paused.formattedRemainingTime
            : breakActive != null
            ? breakActive.formattedRemainingTime
            : '00:00';

        final progress = active != null
            ? (totalSeconds - remainingSeconds) / totalSeconds
            : breakActive != null
            ? (totalSeconds - remainingSeconds) / totalSeconds
            : 0.0;

        final modeLabel = breakActive != null
            ? 'Break time'
            : paused != null
            ? 'Paused'
            : active != null
            ? 'Focus block'
            : 'All set';

        // ── Sound state ───────────────────────────────────────────────────
        // Show the sound control only during active study or paused states
        // and only when a sound other than 'none' is configured.
        final showSoundButton =
            (active?.soundEnabled ?? paused?.soundEnabled ?? false);
        final isMuted = active?.isMuted ?? paused?.isMuted ?? false;

        // ── Action section ────────────────────────────────────────────────
        Widget actionSection;

        if (active != null) {
          actionSection = Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _cubit.pauseSession(),
                  icon: const Icon(Icons.pause_rounded),
                  label: const Text('Pause'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _cubit.finishSession(),
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Finish'),
                ),
              ),
            ],
          );
        } else if (paused != null) {
          actionSection = Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _cubit.cancelSession(),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _cubit.resumeSession(),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Resume'),
                ),
              ),
            ],
          );
        } else if (breakActive != null) {
          actionSection = SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _cubit.completeBreak(),
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Next session'),
            ),
          );
        } else {
          actionSection = SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to plan'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Study session'),
            actions: [
              if (showSoundButton)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    tooltip: isMuted ? 'Unmute sound' : 'Mute sound',
                    icon: Icon(
                      isMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                    ),
                    onPressed: () => _cubit.toggleMute(),
                  ),
                ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Color(
                                subject.color,
                              ).withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              _subjectIcon(subject.icon),
                              color: Color(subject.color),
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            subject.name,
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            modeLabel,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            timerLabel,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: progress.isFinite
                                ? progress.clamp(0.0, 1.0)
                                : 0.0,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            breakActive != null
                                ? 'Break ends soon'
                                : paused != null
                                ? 'Ready when you are'
                                : active != null
                                ? '${_formatDuration(totalSeconds - remainingSeconds)} completed'
                                : 'Session complete',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.mutedForeground,
                            ),
                          ),
                          // ── Sound indicator pill ───────────────────────
                          if (showSoundButton) ...[
                            const SizedBox(height: 12),
                            _SoundIndicator(isMuted: isMuted),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  actionSection,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String _formatDuration(int elapsedSeconds) {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static IconData _subjectIcon(String key) {
    const map = <String, IconData>{
      'calculate': Icons.calculate_outlined,
      'science': Icons.science_outlined,
      'language': Icons.translate_outlined,
      'history': Icons.history_edu_outlined,
      'book': Icons.book_rounded,
      'palette': Icons.palette_outlined,
      'music': Icons.music_note_outlined,
      'computer': Icons.computer_outlined,
      'biotech': Icons.biotech_outlined,
      'code': Icons.code_outlined,
    };
    return map[key] ?? Icons.book_rounded;
  }
}

/// Small pill that shows the current sound playback state.
class _SoundIndicator extends StatelessWidget {
  const _SoundIndicator({required this.isMuted});

  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isMuted
        ? theme.colorScheme.onSurface.withValues(alpha: 0.38)
        : theme.colorScheme.primary;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Row(
        key: ValueKey(isMuted),
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMuted ? Icons.volume_off_rounded : Icons.graphic_eq_rounded,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isMuted ? 'Sound muted' : 'Ambient sound playing',
            style: theme.textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/session/cubit/session_cubit.dart';


/// Full-screen modal overlay shown when a study milestone is reached.
///
/// Call via [CelebrationCard.show] — it manages its own [ConfettiController]
/// and dismisses itself after the student taps the button.
class CelebrationCard extends StatefulWidget {
  const CelebrationCard({
    super.key,
    required this.reason,
    required this.subjectName,
  });

  final CelebrationReason reason;
  final String subjectName;

  /// Shows the celebration as a dialog so it overlays the session screen.
  static Future<void> show(
    BuildContext context, {
    required CelebrationReason reason,
    required String subjectName,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) =>
          CelebrationCard(reason: reason, subjectName: subjectName),
    );
  }

  @override
  State<CelebrationCard> createState() => _CelebrationCardState();
}

class _CelebrationCardState extends State<CelebrationCard> {
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    // Small delay so the dialog paint is complete before confetti starts.
    Future.microtask(_confetti.play);
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  // ── Copy helpers ───────────────────────────────────────────────────────────

  String get _emoji {
    return switch (widget.reason) {
      CelebrationReason.subjectCompleted => '🎉',
      CelebrationReason.dailyGoalReached => '🏆',
      CelebrationReason.both => '🌟',
      CelebrationReason.none => '✅',
    };
  }

  String get _title {
    return switch (widget.reason) {
      CelebrationReason.subjectCompleted => 'Subject complete!',
      CelebrationReason.dailyGoalReached => 'Daily goal reached!',
      CelebrationReason.both => 'Double milestone!',
      CelebrationReason.none => 'Session complete!',
    };
  }

  String get _body {
    return switch (widget.reason) {
      CelebrationReason.subjectCompleted =>
        'You finished your planned session for ${widget.subjectName}. '
            'Keep up the great work!',
      CelebrationReason.dailyGoalReached =>
        "You've hit your study goal for today. "
            'Every minute counts — you should be proud!',
      CelebrationReason.both =>
        'You finished ${widget.subjectName} AND hit your daily study goal. '
            "That's an incredible effort today!",
      CelebrationReason.none => 'Great job completing the session!',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;
    final scheme = theme.colorScheme;

    // Confetti colours drawn from the app palette.
    final confettiColors = [
      scheme.primary,
      colors.success,
      colors.accent,
      colors.chart4,
      colors.warning,
    ];

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // ── Dialog card ────────────────────────────────────────────────────
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusXl),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Emoji badge
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _emoji,
                      style: const TextStyle(fontSize: 38),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),

                // Body
                Text(
                  _body,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.mutedForeground,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),

                // Dismiss button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Confetti cannon centred at the top of the screen ───────────────
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 30,
          maxBlastForce: 30,
          minBlastForce: 10,
          emissionFrequency: 0.05,
          gravity: 0.2,
          colors: confettiColors,
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/core/services/achievement_service.dart';
import 'package:study_planner/features/achievements/cubit/achievements_cubit.dart';
import 'package:study_planner/features/achievements/presentation/widgets/achievement_grid.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/achievement_definition.dart';


class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AchievementsCubit(
        achievementService: getIt<AchievementService>(),
      )..loadAchievements(),
      child: const _AchievementsView(),
    );
  }
}

class _AchievementsView extends StatelessWidget {
  const _AchievementsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.achievements),
      ),
      body: BlocBuilder<AchievementsCubit, AchievementsState>(
        builder: (context, state) {
          if (state is AchievementsLoading ||
              state is AchievementsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AchievementsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is! AchievementsLoaded) {
            return const SizedBox.shrink();
          }

          final unlocked = state.unlockedAchievements;
          final total = AchievementDefinitions.all.length;
          final unlockedCount = unlocked.length;

          return RefreshIndicator(
            onRefresh: () {
              return context
                  .read<AchievementsCubit>()
                  .refresh();
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _AchievementSummary(
                  unlockedCount: unlockedCount,
                  totalCount: total,
                ),

                const SizedBox(height: 24),

                Text(
                  l10n.yourAchievements,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),

                const SizedBox(height: 14),

                AchievementGrid(
                  unlockedAchievements: unlocked,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AchievementSummary extends StatelessWidget {
  const _AchievementSummary({
    required this.unlockedCount,
    required this.totalCount,
  });

  final int unlockedCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final progress = totalCount == 0
        ? 0.0
        : unlockedCount / totalCount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(
                    alpha: 0.12,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.achievementsUnlocked(unlockedCount, totalCount),
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.keepStudyingToUnlockMore,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
          ),
        ],
      ),
    );
  }
}

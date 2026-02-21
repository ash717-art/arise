import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/quest_service.dart';
import 'package:myapp/providers/progress_provider.dart';
import 'package:myapp/models/player_progress.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/quest_info_modal.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SizedBox(height: 40),
            _Header(),
            SizedBox(height: 24),
            _TodaysWorkoutCard(),
            SizedBox(height: 24),
            _XpLevelCard(),
            SizedBox(height: 24),
            _StreakTrackerCard(),
            SizedBox(height: 24),
            _QuickStats(),
            SizedBox(height: 24),
            _MilestoneCard(),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(playerProgressProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WELCOME BACK,', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 2),
            Text(
              progress.valueOrNull?.playerName ?? 'PLAYER ONE',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        progress.when(
          loading: () => const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          error: (_, __) => const CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.primaryAccent,
            child: Icon(Icons.person, size: 22, color: Colors.white),
          ),
          data: (p) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'RANK: ${p.rank}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LVL ${p.level}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.emoji_events,
                    color: AppTheme.primaryAccent,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TodaysWorkoutCard extends ConsumerWidget {
  const _TodaysWorkoutCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyQuestAsync = ref.watch(dailyQuestProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.subtleBorder),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonHighlightGreen.withAlpha(26),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: dailyQuestAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (quest) {
          final duration = quest.exercises.length * 5;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Workout',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${quest.exercises.length} exercises • ${quest.xpReward} XP • ~$duration min',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => QuestInfoModal(quest: quest),
                    );
                  },
                  child: const Text('Start Workout'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _XpLevelCard extends ConsumerWidget {
  const _XpLevelCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(playerProgressProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('Error loading progress: $e'),
        data: (p) {
          final needed = PlayerProgress.xpPerLevel;
          final current = p.xpIntoLevel;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('XP', style: Theme.of(context).textTheme.headlineSmall),
                  Text(
                    'NEXT RANK: ASCENDING',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: p.levelProgress.clamp(0, 1),
                  backgroundColor: AppTheme.subtleBorder,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryAccent,
                  ),
                  minHeight: 12,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'XP: ${p.totalXp}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    '$current / $needed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '90-day quests: ${p.questsCompleted}/${PlayerProgress.totalProgramQuests} • S-rank unlocks only at day 90',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StreakTrackerCard extends ConsumerWidget {
  const _StreakTrackerCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(playerProgressProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Column(
        children: [
          progress.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error loading progress: $e'),
            data: (p) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('🔥 ${p.currentStreak}',
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                      Text(
                        'Current Streak',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 40, width: 1, color: AppTheme.subtleBorder),
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '🏆 ${p.highestStreak}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Text(
                        'Best Streak',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Consistency builds strength.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(title: 'Calories', value: '750'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatTile(title: 'Minutes', value: '45'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatTile(title: 'Completion', value: '80%'),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String title;
  final String value;
  const _StatTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: AppTheme.neonHighlightGreen, size: 20),
          const SizedBox(width: 12),
          Text(
            '3 workouts to next level.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.neonHighlightGreen),
          ),
        ],
      ),
    );
  }
}

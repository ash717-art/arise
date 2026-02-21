import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/player_progress.dart';
import 'package:myapp/providers/progress_provider.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/metric_card.dart';
import 'package:myapp/widgets/stat_pill.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(playerProgressProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: progress.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (p) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 24),
              MetricCard(
                title: 'Rank & Level',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatPill(label: 'Rank', value: p.rank),
                    StatPill(label: 'Level', value: '${p.level}'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              MetricCard(
                title: 'Experience Points',
                child: Column(
                  children: [
                    Text('${p.totalXp} XP',
                        style: Theme.of(context).textTheme.displaySmall),
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
                          'XP to next level: ${PlayerProgress.xpPerLevel - p.xpIntoLevel}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                        ),
                        Text(
                          '${p.xpIntoLevel} / ${PlayerProgress.xpPerLevel}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              MetricCard(
                title: 'Quests Completed',
                child: Center(
                  child: Text(
                    '${p.questsCompleted} / ${PlayerProgress.totalProgramQuests}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

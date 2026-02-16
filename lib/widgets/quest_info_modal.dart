import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/quest_model.dart';
import 'package:myapp/providers/progress_provider.dart';
import 'package:myapp/theme/theme.dart';

class QuestInfoModal extends ConsumerWidget {
  final Quest quest;

  const QuestInfoModal({super.key, required this.quest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.tileBackground.withAlpha(179),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.subtleBorder),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppTheme.primaryAccent),
                      const SizedBox(width: 10),
                      Text('QUEST INFO', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '[${quest.summary}]',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 18),
                  ...quest.exercises
                      .map((ex) => _buildExerciseInfo(context, ex))
                      .expand((w) => [w, const SizedBox(height: 14)]),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppTheme.primaryAccent, width: 1)),
                    ),
                    child: Text(
                      'REWARD: ${quest.xpReward}xp',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryAccent),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            HapticFeedback.mediumImpact();
                            await ref.read(playerProgressProvider.notifier).completeQuest(quest);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quest cleared • +${quest.xpReward}xp'),
                                  backgroundColor: AppTheme.successGreen.withOpacity(0.95),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child: const Text('Complete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseInfo(BuildContext context, QuestExercise questExercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questExercise.exercise.name.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 2),
        Text(
          '${questExercise.sets} × ${questExercise.reps}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primaryAccent),
        ),
        const SizedBox(height: 6),
        Text(
          questExercise.exercise.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 6),
        Text(
          'Tip: Control the eccentric and breathe.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: AppTheme.textSecondary,
              ),
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/models/quest_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/services/exercise_service.dart';

final exerciseServiceProvider = Provider<ExerciseService>((ref) => ExerciseService());

final questServiceProvider = Provider<QuestService>((ref) {
  final onboardingModel = ref.watch(onboardingProvider);
  final exerciseService = ref.watch(exerciseServiceProvider);
  return QuestService(onboardingModel, exerciseService);
});

final dailyQuestProvider = FutureProvider<Quest>((ref) async {
  final questService = ref.watch(questServiceProvider);
  return questService.generateDailyQuest(DateTime.now());
});


class QuestService {
  final OnboardingModel onboardingModel;
  final ExerciseService exerciseService;

  QuestService(this.onboardingModel, this.exerciseService);

  Quest generateDailyQuest(DateTime date) {
    final dayKey = _dayKey(date);

    // Deterministic daily variation (changes each day; same day => same quest).
    final genderName = onboardingModel.gender?.name ?? 'unknown';
    final goalName = onboardingModel.goal?.name ?? 'stayInShape';
    final focusNames = onboardingModel.focusAreas.map((e) => e.name).join(',');
    final rng = Random(_stableSeed('$dayKey:$genderName:$goalName:$focusNames'));

    // Pull exercises matching user's focus. If full body selected, we mix categories.
    final focusAreas = onboardingModel.focusAreas;
    final goal = onboardingModel.goal ?? Goal.stayInShape;

    final pool = exerciseService.getExercisesForFocus(focusAreas, goal: goal, availableEquipment: onboardingModel.equipment.isEmpty ? const [Equipment.none] : onboardingModel.equipment);

    // Choose 4-6 unique exercises depending on fitness level.
    final count = switch (onboardingModel.fitnessLevel) {
      FitnessLevel.beginner => 4,
      FitnessLevel.intermediate => 5,
      FitnessLevel.advanced => 6,
      _ => 4,
    };

    final selected = _pickUnique(pool, count, rng);

    // Sets/reps tuned by goal + fitness level.
    final questExercises = selected.map((ex) {
      final (sets, reps) = _prescriptionFor(ex, goal, onboardingModel.fitnessLevel ?? FitnessLevel.beginner, rng);
      return QuestExercise(exercise: ex, sets: sets, reps: reps);
    }).toList();

    final xpReward = _computeXpReward(questExercises.length, onboardingModel.fitnessLevel ?? FitnessLevel.beginner, rng);

    final summary = _makeSummary(goal, focusAreas, rng);

    return Quest(
      id: 'quest_$dayKey',
      date: DateTime(date.year, date.month, date.day),
      exercises: questExercises,
      xpReward: xpReward,
      summary: summary,
    );
  }

  List<Exercise> _pickUnique(List<Exercise> pool, int count, Random rng) {
    final copy = List<Exercise>.from(pool);
    copy.shuffle(rng);
    return copy.take(count.clamp(1, copy.length)).toList();
  }

  (int sets, int reps) _prescriptionFor(
    Exercise ex,
    Goal goal,
    FitnessLevel level,
    Random rng,
  ) {
    // Base targets by level
    int baseSets = switch (level) {
      FitnessLevel.beginner => 3,
      FitnessLevel.intermediate => 4,
      FitnessLevel.advanced => 4,
    };

    // Goal adjusts reps (muscle => moderate, weight loss => slightly higher).
    int baseReps = switch (goal) {
      Goal.buildMuscle => 8 + rng.nextInt(5),     // 8-12
      Goal.loseWeight => 10 + rng.nextInt(7),     // 10-16
      Goal.lookBetter => 10 + rng.nextInt(5),     // 10-14
      Goal.stayInShape => 10 + rng.nextInt(5),    // 10-14
    };

    // Conditioning moves get higher reps.
    if (ex.type == ExerciseType.conditioning) {
      baseReps += 6;
      baseSets = (baseSets - 1).clamp(2, 4);
    }

    return (baseSets, baseReps);
  }

  int _computeXpReward(int exerciseCount, FitnessLevel level, Random rng) {
    final base = switch (level) {
      FitnessLevel.beginner => 35,
      FitnessLevel.intermediate => 45,
      FitnessLevel.advanced => 55,
    };
    // Mild daily variance but stable for the day
    return base + (exerciseCount * 5) + rng.nextInt(11) - 5;
  }

  String _makeSummary(Goal goal, List<FocusArea> focus, Random rng) {
    final focusText = focus.contains(FocusArea.fullBody)
        ? 'the entire body'
        : focus.isEmpty
            ? 'full body'
            : focus.length > 1
                ? 'multiple systems'
                : focus.first.name.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[1]}').trim().toLowerCase();

    final openers = [
      'Basic bodyweight exercises targeting $focusText to build strength and endurance.',
      'A focused $focusText circuit designed to level you up through consistency.',
      'Today’s protocol trains $focusText with clean form and controlled tempo.',
      'A short but brutal $focusText quest—finish it and claim your reward.',
    ];

    final goalLine = switch (goal) {
      Goal.buildMuscle => 'Prioritize tension and full range—this is for muscle growth.',
      Goal.loseWeight => 'Keep rest short and pace steady—this supports fat loss.',
      Goal.lookBetter => 'Move with control—this improves posture, shape, and definition.',
      Goal.stayInShape => 'Stay consistent—this maintains strength and conditioning.',
    };

    return '${openers[rng.nextInt(openers.length)]}\n$goalLine';
  }

  String _dayKey(DateTime date) => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  int _stableSeed(String input) {
    // Simple stable hash
    var h = 0;
    for (final c in input.codeUnits) {
      h = 0x1fffffff & (h + c);
      h = 0x1fffffff & (h + ((0x0007ffff & h) << 10));
      h ^= (h >> 6);
    }
    h = 0x1fffffff & (h + ((0x03ffffff & h) << 3));
    h ^= (h >> 11);
    h = 0x1fffffff & (h + ((0x00003fff & h) << 15));
    return h;
  }
}

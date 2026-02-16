import 'package:myapp/models/exercise_model.dart';

class QuestExercise {
  final Exercise exercise;
  final int sets;
  final int reps;

  QuestExercise({
    required this.exercise,
    required this.sets,
    required this.reps,
  });
}

class Quest {
  final String id;
  final DateTime date;
  final List<QuestExercise> exercises;
  final int xpReward;

  /// Short cinematic description shown in QUEST INFO.
  final String summary;

  Quest({
    required this.id,
    required this.date,
    required this.exercises,
    required this.xpReward,
    required this.summary,
  });
}

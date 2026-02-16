import 'package:myapp/models/onboarding_model.dart';

enum ExerciseType { push, pull, legs, core, conditioning }

class Exercise {
  final String id;
  final String name;
  final ExerciseType type;
  final String description;
  final List<Equipment> requiredEquipment;
  final int difficulty; // e.g., 1 to 5

  const Exercise({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    this.requiredEquipment = const [],
    this.difficulty = 1,
  });
}

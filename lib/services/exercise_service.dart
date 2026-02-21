import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/onboarding_model.dart';

class ExerciseService {
  static final List<Exercise> _exercises = [
    // Push
    const Exercise(
      id: 'push_up',
      name: 'Push-ups',
      type: ExerciseType.push,
      description:
          'A classic bodyweight exercise that works the chest, shoulders, and triceps.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'incline_push_up',
      name: 'Incline Push-ups',
      type: ExerciseType.push,
      description:
          'A variation of the push-up that places more emphasis on the lower chest. Easier than a standard push-up.',
      difficulty: 1,
    ),
    const Exercise(
      id: 'dips',
      name: 'Dips',
      type: ExerciseType.push,
      description:
          'A compound exercise that targets the triceps, chest, and shoulders. Requires parallel bars or a sturdy edge.',
      requiredEquipment: [Equipment.fullGym], // Or some kind of bars
      difficulty: 3,
    ),
    const Exercise(
      id: 'pike_push_up',
      name: 'Pike Push-ups',
      type: ExerciseType.push,
      description:
          'A challenging push-up variation that shifts the focus to the shoulders.',
      difficulty: 3,
    ),
    const Exercise(
      id: 'db_bench_press',
      name: 'Dumbbell Bench Press',
      type: ExerciseType.push,
      description:
          'A fundamental upper body exercise using dumbbells to work the chest, triceps, and shoulders.',
      requiredEquipment: [Equipment.dumbbells],
      difficulty: 3,
    ),

    // Pull
    const Exercise(
      id: 'pull_up',
      name: 'Pull-ups',
      type: ExerciseType.pull,
      description:
          'A challenging bodyweight exercise that targets the back and biceps. Requires a pull-up bar.',
      requiredEquipment: [Equipment.fullGym], // Or a bar
      difficulty: 4,
    ),
    const Exercise(
      id: 'inverted_row',
      name: 'Inverted Rows',
      type: ExerciseType.pull,
      description:
          'A bodyweight exercise that targets the back and biceps. Can be done with a bar or a sturdy table.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'db_row',
      name: 'Dumbbell Rows',
      type: ExerciseType.pull,
      description: 'A classic back-building exercise using a dumbbell.',
      requiredEquipment: [Equipment.dumbbells],
      difficulty: 3,
    ),

    // Legs
    const Exercise(
      id: 'squat',
      name: 'Squats',
      type: ExerciseType.legs,
      description:
          'A fundamental lower body exercise that targets the quadriceps, hamstrings, and glutes.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'lunge',
      name: 'Lunges',
      type: ExerciseType.legs,
      description:
          'A unilateral leg exercise that works the quads, glutes, and hamstrings.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'step_up',
      name: 'Step-ups',
      type: ExerciseType.legs,
      description:
          'An exercise that involves stepping up onto a raised platform, targeting the quads and glutes.',
      difficulty: 1,
    ),
    const Exercise(
      id: 'glute_bridge',
      name: 'Glute Bridges',
      type: ExerciseType.legs,
      description: 'An exercise that isolates the gluteal muscles.',
      difficulty: 1,
    ),
    const Exercise(
      id: 'goblet_squat',
      name: 'Goblet Squat',
      type: ExerciseType.legs,
      description:
          'A squat variation holding a single dumbbell or kettlebell at chest height.',
      requiredEquipment: [Equipment.dumbbells],
      difficulty: 3,
    ),

    // Core
    const Exercise(
      id: 'plank',
      name: 'Plank',
      type: ExerciseType.core,
      description:
          'An isometric core exercise that involves maintaining a position similar to a push-up for the maximum possible time.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'leg_raise',
      name: 'Leg Raises',
      type: ExerciseType.core,
      description: 'An exercise that targets the lower abdominal muscles.',
      difficulty: 2,
    ),
    const Exercise(
      id: 'mountain_climber',
      name: 'Mountain Climbers',
      type: ExerciseType.core,
      description: 'A dynamic core exercise that also elevates the heart rate.',
      difficulty: 3,
    ),
    const Exercise(
      id: 'russian_twist',
      name: 'Russian Twists',
      type: ExerciseType.core,
      description: 'A core exercise that targets the oblique muscles.',
      difficulty: 2,
    ),

    // Conditioning
    const Exercise(
      id: 'burpee',
      name: 'Burpees',
      type: ExerciseType.conditioning,
      description:
          'A full-body exercise used in strength training and as an aerobic exercise.',
      difficulty: 4,
    ),
    const Exercise(
      id: 'jogging',
      name: 'Jogging',
      type: ExerciseType.conditioning,
      description: 'A form of trotting or running at a slow or leisurely pace.',
      difficulty: 1,
    ),
    const Exercise(
      id: 'shadow_boxing',
      name: 'Shadow Boxing',
      type: ExerciseType.conditioning,
      description:
          'A combat sport exercise in which a person throws punches at the air as if they were fighting an opponent.',
      difficulty: 2,
    ),
  ];

  List<Exercise> getExercises() {
    return _exercises;
  }

  List<Exercise> getAvailableExercises(List<Equipment> availableEquipment) {
    if (availableEquipment.contains(Equipment.fullGym)) {
      return _exercises;
    }
    if (availableEquipment.contains(Equipment.none)) {
      return _exercises.where((ex) => ex.requiredEquipment.isEmpty).toList();
    }

    return _exercises.where((ex) {
      return ex.requiredEquipment.isEmpty ||
          ex.requiredEquipment.any((req) => availableEquipment.contains(req));
    }).toList();
  }

  List<Exercise> getExercisesForFocus(
    List<FocusArea> focusAreas, {
    required Goal goal,
    List<Equipment> availableEquipment = const [Equipment.none],
  }) {
    final types = <ExerciseType>{};

    if (focusAreas.contains(FocusArea.fullBody) || focusAreas.isEmpty) {
      types.addAll(ExerciseType.values);
    } else {
      for (final f in focusAreas) {
        switch (f) {
          case FocusArea.chest:
          case FocusArea.shoulders:
          case FocusArea.arms:
            types.add(ExerciseType.push);
            types.add(ExerciseType.pull);
            break;
          case FocusArea.back:
            types.add(ExerciseType.pull);
            break;
          case FocusArea.abs:
            types.add(ExerciseType.core);
            break;
          case FocusArea.legs:
            types.add(ExerciseType.legs);
            break;
          case FocusArea.fullBody:
            types.addAll(ExerciseType.values);
            break;
        }
      }
    }

    // Weight-loss / conditioning goals bias toward conditioning.
    final wantConditioning =
        goal == Goal.loseWeight || goal == Goal.stayInShape;

    final filtered = _exercises.where((e) {
      if (!types.contains(e.type)) return false;

      // Equipment gate: if an exercise requires equipment, user must have at least one matching option.
      if (e.requiredEquipment.isNotEmpty) {
        final has = e.requiredEquipment.any(
          (req) =>
              availableEquipment.contains(req) ||
              availableEquipment.contains(Equipment.fullGym),
        );
        if (!has) return false;
      }

      return true;
    }).toList();

    if (filtered.isEmpty) {
      return getExercises(); // fallback
    }

    // Simple bias: duplicate conditioning entries to increase chance.
    if (wantConditioning) {
      final conditioning = filtered
          .where((e) => e.type == ExerciseType.conditioning)
          .toList();
      if (conditioning.isNotEmpty) {
        filtered.addAll(conditioning);
        filtered.addAll(conditioning);
      }
    }

    return filtered;
  }
}

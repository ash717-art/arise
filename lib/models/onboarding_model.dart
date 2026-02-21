enum Gender { male, female, other }

enum Goal { buildMuscle, loseWeight, lookBetter, stayInShape }

enum Motivation {
  health,
  weightLoss,
  appearance,
  stressRelief,
  socialSupport,
  enjoyment,
}

enum FocusArea { fullBody, chest, back, arms, shoulders, abs, legs }

enum FitnessLevel { beginner, intermediate, advanced }

enum ActivityLevel { sedentary, lightly, moderately, very }

enum HealthIssue { none, knee, hip, back, arms, noJumps }

enum Equipment { none, fullGym, barbells, dumbbells, kettlebells, machines }

class OnboardingModel {
  final Gender? gender;
  final Goal? goal;
  final List<Motivation> motivations;
  final List<FocusArea> focusAreas;
  final FitnessLevel? fitnessLevel;
  final ActivityLevel? activityLevel;
  final double currentWeight;
  final String weightUnit;
  final double targetWeight;
  final double height;
  final String heightUnit;
  final HealthIssue? healthIssue;
  final List<Equipment> equipment;
  final int workoutsPerWeek;
  final List<String> workoutDays;
  final bool remindersEnabled;

  // Aliases for convenience
  double get weightKg => currentWeight;
  double get targetWeightKg => targetWeight;

  OnboardingModel({
    this.gender,
    this.goal,
    this.motivations = const [],
    this.focusAreas = const [],
    this.fitnessLevel,
    this.activityLevel,
    this.currentWeight = 60,
    this.weightUnit = 'kg',
    this.targetWeight = 65,
    this.height = 170,
    this.heightUnit = 'cm',
    this.healthIssue,
    this.equipment = const [],
    this.workoutsPerWeek = 4,
    this.workoutDays = const [],
    this.remindersEnabled = true,
  });

  OnboardingModel copyWith({
    Gender? gender,
    Goal? goal,
    List<Motivation>? motivations,
    List<FocusArea>? focusAreas,
    FitnessLevel? fitnessLevel,
    ActivityLevel? activityLevel,
    double? currentWeight,
    String? weightUnit,
    double? targetWeight,
    double? height,
    String? heightUnit,
    HealthIssue? healthIssue,
    List<Equipment>? equipment,
    int? workoutsPerWeek,
    List<String>? workoutDays,
    bool? remindersEnabled,
  }) {
    return OnboardingModel(
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      motivations: motivations ?? this.motivations,
      focusAreas: focusAreas ?? this.focusAreas,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      activityLevel: activityLevel ?? this.activityLevel,
      currentWeight: currentWeight ?? this.currentWeight,
      weightUnit: weightUnit ?? this.weightUnit,
      targetWeight: targetWeight ?? this.targetWeight,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      healthIssue: healthIssue ?? this.healthIssue,
      equipment: equipment ?? this.equipment,
      workoutsPerWeek: workoutsPerWeek ?? this.workoutsPerWeek,
      workoutDays: workoutDays ?? this.workoutDays,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    );
  }
}

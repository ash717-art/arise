import 'package:myapp/models/onboarding_model.dart';

class NutritionScreenViewModel {
  final OnboardingModel onboardingModel;

  NutritionScreenViewModel(this.onboardingModel);

  double get tdee => _calculateTdee(onboardingModel);
  double get calorieGoal => _calculateCalorieGoal(tdee, onboardingModel.goal!);
  Map<String, double> get macros => _calculateMacros(
        calorieGoal,
        onboardingModel.currentWeight,
        onboardingModel.goal!,
      );
  double get waterGoal => _calculateWaterGoal(
        onboardingModel.currentWeight,
        onboardingModel.activityLevel!,
      );

  double _calculateTdee(OnboardingModel model) {
    // Mifflin-St Jeor Equation for BMR
    // Assume age 25, can be changed later
    final age = 25;
    double bmr;
    if (model.gender == Gender.male) {
      bmr = 10 * model.currentWeight + 6.25 * model.height - 5 * age + 5;
    } else {
      bmr = 10 * model.currentWeight + 6.25 * model.height - 5 * age - 161;
    }

    double activityMultiplier;
    switch (model.activityLevel) {
      case ActivityLevel.sedentary:
        activityMultiplier = 1.2;
        break;
      case ActivityLevel.lightly:
        activityMultiplier = 1.375;
        break;
      case ActivityLevel.moderately:
        activityMultiplier = 1.55;
        break;
      case ActivityLevel.very:
        activityMultiplier = 1.725;
        break;
      default:
        activityMultiplier = 1.2;
    }

    return bmr * activityMultiplier;
  }

  double _calculateCalorieGoal(double tdee, Goal goal) {
    switch (goal) {
      case Goal.loseWeight:
        return tdee * 0.85; // 15% deficit
      case Goal.buildMuscle:
        return tdee * 1.1; // 10% surplus
      case Goal.lookBetter:
      case Goal.stayInShape:
        return tdee;
    }
  }

  Map<String, double> _calculateMacros(
    double calories,
    double weightKg,
    Goal goal,
  ) {
    double proteinG, fatG, carbsG;

    proteinG = weightKg * (goal == Goal.buildMuscle ? 2.0 : 1.8);
    fatG = (calories * 0.25) / 9;

    final remainingCalories = calories - (proteinG * 4) - (fatG * 9);
    carbsG = remainingCalories / 4;

    return {'protein': proteinG, 'fat': fatG, 'carbs': carbsG};
  }

  double _calculateWaterGoal(double weightKg, ActivityLevel activityLevel) {
    double base = weightKg * 35 / 240; // in cups
    if (activityLevel == ActivityLevel.very) {
      base *= 1.2;
    }
    return base;
  }
}

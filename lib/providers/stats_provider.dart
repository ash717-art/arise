import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';

final baselineStatsProvider = Provider<Map<String, double>>((ref) {
  final onboardingModel = ref.watch(onboardingProvider);
  return _calculateBaselineStats(onboardingModel);
});

Map<String, double> _calculateBaselineStats(OnboardingModel model) {
    double strength = 0;
    double vitality = 0;
    double agility = 0;
    double recovery = 0;

    // Fitness Level Contribution
    switch (model.fitnessLevel) {
      case FitnessLevel.beginner:
        strength += 10;
        vitality += 15;
        agility += 10;
        recovery += 20;
        break;
      case FitnessLevel.intermediate:
        strength += 20;
        vitality += 25;
        agility += 20;
        recovery += 15;
        break;
      case FitnessLevel.advanced:
        strength += 30;
        vitality += 35;
        agility += 30;
        recovery += 10;
        break;
      default:
        break;
    }

    // Activity Level Contribution
    switch (model.activityLevel) {
      case ActivityLevel.sedentary:
        vitality += 5;
        recovery += 5;
        break;
      case ActivityLevel.lightly:
        vitality += 10;
        agility += 5;
        break;
      case ActivityLevel.moderately:
        vitality += 15;
        strength += 5;
        agility += 10;
        break;
      case ActivityLevel.very:
        vitality += 20;
        strength += 10;
        agility += 15;
        break;
      default:
        break;
    }
    
    // Goal Contribution
    if (model.goal == Goal.buildMuscle) strength += 15;
    if (model.goal == Goal.loseWeight) vitality += 10;

    // Focus Area Contribution
    if (model.focusAreas.contains(FocusArea.legs)) agility += 10;
    if (model.focusAreas.contains(FocusArea.fullBody)) {
      strength +=5;
      vitality +=5;
      agility +=5;
    }

    return {
      'Strength': strength.clamp(0, 100),
      'Vitality': vitality.clamp(0, 100),
      'Agility': agility.clamp(0, 100),
      'Recovery': recovery.clamp(0, 100),
    };
}

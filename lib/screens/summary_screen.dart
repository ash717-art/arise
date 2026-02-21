import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bmi_scale_bar.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/metric_card.dart';
import 'package:myapp/widgets/weight_trend_chart.dart';
import 'package:myapp/screens/loading/syncing_data_screen.dart';
import 'package:myapp/widgets/stat_pill.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);

    // Calculations
    final bmi = _calculateBmi(
      onboardingModel.currentWeight,
      onboardingModel.height,
    );
    final bmiCategory = _getBmiCategory(bmi);
    final tdee = _calculateTdee(onboardingModel);
    final calorieGoal = _calculateCalorieGoal(tdee, onboardingModel.goal!);
    final macros = _calculateMacros(
      calorieGoal,
      onboardingModel.currentWeight,
      onboardingModel.goal!,
    );
    final waterGoal = _calculateWaterGoal(
      onboardingModel.currentWeight,
      onboardingModel.activityLevel!,
    );
    final weightTrend = _generateWeightTrend(onboardingModel);
    final focusAreaText =
        onboardingModel.focusAreas.contains(FocusArea.fullBody)
        ? 'Full Body'
        : onboardingModel.focusAreas.length > 1
        ? 'Multiple'
        : onboardingModel.focusAreas.first.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Summary Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here’s your summary preview. Tap continue to get your custom plan',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Weight Trend',
              child: WeightTrendChart(
                points: weightTrend,
                startLabel: onboardingModel.weightUnit == 'lbs'
                    ? '${onboardingModel.currentWeight.round()} lbs'
                    : '${onboardingModel.currentWeight.toStringAsFixed(1)} kg',
                endLabel: onboardingModel.weightUnit == 'lbs'
                    ? '${onboardingModel.targetWeight.round()} lbs'
                    : '${onboardingModel.targetWeight.toStringAsFixed(1)} kg',
              ),
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Body Mass Index (BMI)',
              child: Column(
                children: [
                  Text(
                    bmi.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    bmiCategory,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BmiScaleBar(bmiValue: bmi),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: StatPill(
                    label: 'Fitness',
                    value: onboardingModel.fitnessLevel!.name,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatPill(
                    label: 'Activity',
                    value: onboardingModel.activityLevel!.name,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatPill(label: 'Focus', value: focusAreaText),
                ),
              ],
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Calorie & Macros Goal',
              child: Column(
                children: [
                  Text(
                    '${calorieGoal.round()} kcal/day',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _macroPill('Protein', macros['protein']!, 'g'),
                      _macroPill('Carbs', macros['carbs']!, 'g'),
                      _macroPill('Fats', macros['fat']!, 'g'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Water Goal',
              child: Center(
                child: Text(
                  '${waterGoal.toStringAsFixed(1)} cups/day',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    title: 'Workout Duration',
                    child: Text(
                      '${_getWorkoutDuration(onboardingModel.fitnessLevel!)} min',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MetricCard(
                    title: 'Rest Time',
                    child: Text(
                      '${_getRestTime(onboardingModel.fitnessLevel!)} min',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Weekly Goal',
              child: Center(
                child: Text(
                  '${onboardingModel.workoutsPerWeek} workouts',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            const SizedBox(height: 40),
            BottomCTAButton(
              text: 'Continue',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SyncingDataScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _macroPill(String title, double value, String unit) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
        Text(
          '${value.round()}$unit',
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  double _calculateBmi(double weightKg, double heightCm) {
    if (heightCm == 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

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

  String _getWorkoutDuration(FitnessLevel level) {
    switch (level) {
      case FitnessLevel.beginner:
        return "35-45";
      case FitnessLevel.intermediate:
        return "45-60";
      case FitnessLevel.advanced:
        return "60-75";
    }
  }

  String _getRestTime(FitnessLevel level) {
    switch (level) {
      case FitnessLevel.beginner:
        return "1.5-2.0";
      case FitnessLevel.intermediate:
        return "1.0-1.5";
      case FitnessLevel.advanced:
        return "0.75-1.25";
    }
  }

  List<double> _generateWeightTrend(OnboardingModel model) {
    // The reference UI shows a meaningful, curved projection (not a flat line).
    // If the user's target is very close to current weight, we still show a
    // realistic minimum change so the chart has shape.
    final start = (model.weightKg.isFinite && model.weightKg > 0)
        ? model.weightKg
        : 70.0;
    var end = (model.targetWeightKg.isFinite && model.targetWeightKg > 0)
        ? model.targetWeightKg
        : start;

    final delta = (end - start).abs();
    if (delta < 1.0) {
      // Enforce a visible change based on goal intent
      final goalStr = model.goal?.name ?? '';
      if (goalStr.toLowerCase().contains('lose')) {
        end = start - (start * 0.07).clamp(4.0, 8.0);
      } else if (goalStr.toLowerCase().contains('build')) {
        end = start + (start * 0.05).clamp(2.0, 6.0);
      } else {
        end = start - (start * 0.04).clamp(2.0, 5.0);
      }
    }

    // 5 points: start -> end, with an ease-in-out curve + slight mid bump
    // (mimics the reference where progress accelerates later).
    final out = <double>[];
    for (int i = 0; i < 5; i++) {
      final t = i / 4.0;
      // smoothstep
      final eased = t * t * (3 - 2 * t);
      var v = start + (end - start) * eased;

      // small "month 2-3" kink
      if (i == 2) {
        v = v + (end > start ? 0.4 : -0.4);
      }
      out.add(v);
    }
    return out;
  }
}

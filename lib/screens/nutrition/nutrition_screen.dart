import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/nutrition/nutrition_screen_view_model.dart';
import 'package:myapp/widgets/metric_card.dart';
import 'package:myapp/widgets/macro_pill.dart';

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final viewModel = NutritionScreenViewModel(onboardingModel);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Text(
              'Your Nutrition',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            MetricCard(
              title: 'Calorie & Macros Goal',
              child: Column(
                children: [
                  Text(
                    '${viewModel.calorieGoal.round()} kcal/day',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MacroPill(
                          title: 'Protein',
                          value: viewModel.macros['protein']!,
                          unit: 'g'),
                      MacroPill(
                          title: 'Carbs',
                          value: viewModel.macros['carbs']!,
                          unit: 'g'),
                      MacroPill(
                          title: 'Fats',
                          value: viewModel.macros['fat']!,
                          unit: 'g'),
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
                  '${viewModel.waterGoal.toStringAsFixed(1)} cups/day',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

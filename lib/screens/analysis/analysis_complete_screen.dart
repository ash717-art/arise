import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import '../program/projection_screen.dart';

class AnalysisCompleteScreen extends ConsumerWidget {
  const AnalysisCompleteScreen({super.key});

  double _calculatePotentialScore(OnboardingModel model) {
    double activityWeight = 0;
    switch (model.activityLevel) {
      case ActivityLevel.sedentary:
        activityWeight = 1;
        break;
      case ActivityLevel.lightly:
        activityWeight = 2;
        break;
      case ActivityLevel.moderately:
        activityWeight = 3;
        break;
      case ActivityLevel.very:
        activityWeight = 4;
        break;
      default:
        break;
    }

    double fitnessLevelWeight = 0;
    switch (model.fitnessLevel) {
      case FitnessLevel.beginner:
        fitnessLevelWeight = 1;
        break;
      case FitnessLevel.intermediate:
        fitnessLevelWeight = 2;
        break;
      case FitnessLevel.advanced:
        fitnessLevelWeight = 3;
        break;
      default:
        break;
    }

    final workoutFrequencyWeight = model.workoutsPerWeek.toDouble();
    final goalConsistencyWeight =
        (model.targetWeight - model.currentWeight).abs();
    final motivationWeight = model.motivations.length.toDouble();

    final score = (activityWeight * 0.25) +
        (fitnessLevelWeight * 0.2) +
        (workoutFrequencyWeight * 0.2) +
        (goalConsistencyWeight * 0.2) +
        (motivationWeight * 0.15);
    
    // Normalize to a 0-100 scale, assuming max possible score is ~15-20
    return (score / 20 * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final potentialScore = _calculatePotentialScore(onboardingModel);
    const averageScore = 65.0; // Assumption for average demographic
    final wastedPotential = ((averageScore - potentialScore) / averageScore * 100).clamp(0, 100);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.backgroundStart, AppTheme.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Analysis complete',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle,
                        color: AppTheme.successGreen, size: 30),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String text = '';
                              if (value == 0) text = 'YOU';
                              if (value == 1) text = 'AVERAGE';
                              return SideTitleWidget(axisSide: meta.axisSide, space: 4.0, child: Text(text, style: Theme.of(context).textTheme.bodyMedium));
                            },
                            reservedSize: 30,
                          ),
                        ),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(
                              toY: potentialScore,
                              color: AppTheme.dangerRed,
                              width: 40,
                              borderRadius: BorderRadius.circular(8)),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                              toY: averageScore,
                              color: AppTheme.mutedGreyLine,
                              width: 40,
                              borderRadius: BorderRadius.circular(8)),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      const TextSpan(text: "You're wasting "),
                      TextSpan(
                        text: '${wastedPotential.toStringAsFixed(0)}% potential',
                        style: const TextStyle(color: AppTheme.dangerRed),
                      ),
                      const TextSpan(text: ' compared to average.'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.tileBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.subtleBorder),
                  ),
                  child: Text(
                    "You’re currently using only ${potentialScore.toStringAsFixed(0)}% of your physical capacity. Most people in your demographic reach around ${averageScore.toStringAsFixed(0)}%.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Spacer(flex: 2),
                BottomCTAButton(
                  text: 'Continue',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ProjectionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
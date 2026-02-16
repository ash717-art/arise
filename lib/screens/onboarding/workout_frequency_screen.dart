import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/workout_days_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class WorkoutFrequencyScreen extends ConsumerWidget {
  const WorkoutFrequencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const TopProgressBar(currentStep: 12, totalSteps: 13),
              const SizedBox(height: 30),
              Text('How often would you like to work out?', style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center,),
              const SizedBox(height: 50),
              Text(
                '${onboardingModel.workoutsPerWeek}x',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 72),
              ),
              Text(
                '${onboardingModel.workoutsPerWeek} workouts a week',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              Slider(
                value: onboardingModel.workoutsPerWeek.toDouble(),
                min: 1,
                max: 7,
                divisions: 6,
                onChanged: (double value) {
                  onboardingNotifier.setWorkoutsPerWeek(value.toInt());
                },
              ),
              const Spacer(),
              BottomCTAButton(
                text: 'Continue',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkoutDaysScreen()));
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

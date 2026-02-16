import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/motivation_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/option_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

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
              const TopProgressBar(currentStep: 2, totalSteps: 13),
              const SizedBox(height: 30),
              Text('Choose your goal', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 30),
              OptionTile(
                title: 'Build Muscle',
                selected: onboardingModel.goal == Goal.buildMuscle,
                onTap: () => onboardingNotifier.setGoal(Goal.buildMuscle),
              ),
              const SizedBox(height: 16),
              OptionTile(
                title: 'Lose Weight',
                selected: onboardingModel.goal == Goal.loseWeight,
                onTap: () => onboardingNotifier.setGoal(Goal.loseWeight),
              ),
              const SizedBox(height: 16),
              OptionTile(
                title: 'Look Better',
                selected: onboardingModel.goal == Goal.lookBetter,
                onTap: () => onboardingNotifier.setGoal(Goal.lookBetter),
              ),
              const SizedBox(height: 16),
              OptionTile(
                title: 'Stay In Shape',
                selected: onboardingModel.goal == Goal.stayInShape,
                onTap: () => onboardingNotifier.setGoal(Goal.stayInShape),
              ),
              const Spacer(),
              BottomCTAButton(
                text: 'Continue',
                enabled: onboardingModel.goal != null,
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MotivationScreen()));
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/activity_level_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/option_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class FitnessLevelScreen extends ConsumerWidget {
  const FitnessLevelScreen({super.key});

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
              const TopProgressBar(currentStep: 5, totalSteps: 13),
              const SizedBox(height: 30),
              Text('What is your fitness level?', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 30),
              OptionTile(
                title: 'Beginner',
                subtitle: 'I’m new or have only tried it for a bit',
                selected: onboardingModel.fitnessLevel == FitnessLevel.beginner,
                onTap: () => onboardingNotifier.setFitnessLevel(FitnessLevel.beginner),
              ),
              const SizedBox(height: 16),
              OptionTile(
                title: 'Intermediate',
                subtitle: 'I’ve lifted weights before',
                selected: onboardingModel.fitnessLevel == FitnessLevel.intermediate,
                onTap: () => onboardingNotifier.setFitnessLevel(FitnessLevel.intermediate),
              ),
              const SizedBox(height: 16),
              OptionTile(
                title: 'Advanced',
                subtitle: 'I’ve been lifting weights for a while',
                selected: onboardingModel.fitnessLevel == FitnessLevel.advanced,
                onTap: () => onboardingNotifier.setFitnessLevel(FitnessLevel.advanced),
              ),
              const Spacer(),
              BottomCTAButton(
                text: 'Continue',
                enabled: onboardingModel.fitnessLevel != null,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ActivityLevelScreen()));
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/focus_areas_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/multi_select_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class MotivationScreen extends ConsumerWidget {
  const MotivationScreen({super.key});

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
              const TopProgressBar(currentStep: 3, totalSteps: 13),
              const SizedBox(height: 30),
              Text('What motivates you?', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    MultiSelectTile(
                      title: 'Health',
                      selected: onboardingModel.motivations.contains(Motivation.health),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.health),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Weight Loss',
                      selected: onboardingModel.motivations.contains(Motivation.weightLoss),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.weightLoss),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Appearance',
                      selected: onboardingModel.motivations.contains(Motivation.appearance),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.appearance),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Stress Relief',
                      selected: onboardingModel.motivations.contains(Motivation.stressRelief),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.stressRelief),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Social Support',
                      selected: onboardingModel.motivations.contains(Motivation.socialSupport),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.socialSupport),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Enjoyment',
                      selected: onboardingModel.motivations.contains(Motivation.enjoyment),
                      onTap: () => onboardingNotifier.toggleMotivation(Motivation.enjoyment),
                    ),
                  ],
                ),
              ),
              BottomCTAButton(
                text: 'Continue',
                enabled: onboardingModel.motivations.isNotEmpty,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FocusAreasScreen()));
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

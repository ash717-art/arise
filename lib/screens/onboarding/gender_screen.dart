import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/goal_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/option_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class GenderScreen extends ConsumerWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopProgressBar(currentStep: 1, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'Choose your gender',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                OptionTile(
                  title: 'Male',
                  selected: onboardingModel.gender == Gender.male,
                  onTap: () => onboardingNotifier.setGender(Gender.male),
                ),
                const SizedBox(height: 16),
                OptionTile(
                  title: 'Female',
                  selected: onboardingModel.gender == Gender.female,
                  onTap: () => onboardingNotifier.setGender(Gender.female),
                ),
                const SizedBox(height: 16),
                OptionTile(
                  title: 'Other',
                  selected: onboardingModel.gender == Gender.other,
                  onTap: () => onboardingNotifier.setGender(Gender.other),
                ),
                BottomCTAButton(
                  text: 'Continue',
                  enabled: onboardingModel.gender != null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GoalScreen()),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

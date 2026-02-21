import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/current_weight_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/option_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class ActivityLevelScreen extends ConsumerWidget {
  const ActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopProgressBar(currentStep: 6, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'What is your activity level?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                OptionTile(
                  title: 'Sedentary',
                  selected:
                      onboardingModel.activityLevel == ActivityLevel.sedentary,
                  onTap: () => onboardingNotifier.setActivityLevel(
                    ActivityLevel.sedentary,
                  ),
                ),
                const SizedBox(height: 16),
                OptionTile(
                  title: 'Lightly Active',
                  subtitle: '1–3 days/week',
                  selected:
                      onboardingModel.activityLevel == ActivityLevel.lightly,
                  onTap: () => onboardingNotifier.setActivityLevel(
                    ActivityLevel.lightly,
                  ),
                ),
                const SizedBox(height: 16),
                OptionTile(
                  title: 'Moderately Active',
                  subtitle: '4–6 days/week',
                  selected:
                      onboardingModel.activityLevel == ActivityLevel.moderately,
                  onTap: () => onboardingNotifier.setActivityLevel(
                    ActivityLevel.moderately,
                  ),
                ),
                const SizedBox(height: 16),
                OptionTile(
                  title: 'Very Active',
                  subtitle: 'Hard exercise daily',
                  selected: onboardingModel.activityLevel == ActivityLevel.very,
                  onTap: () =>
                      onboardingNotifier.setActivityLevel(ActivityLevel.very),
                ),
                BottomCTAButton(
                  text: 'Continue',
                  enabled: onboardingModel.activityLevel != null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CurrentWeightScreen(),
                      ),
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

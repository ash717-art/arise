import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/equipment_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/option_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class HealthIssuesScreen extends ConsumerWidget {
  const HealthIssuesScreen({super.key});

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
                const TopProgressBar(currentStep: 10, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'Any health issues?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    OptionTile(
                      title: 'None',
                      selected: onboardingModel.healthIssue == HealthIssue.none,
                      onTap: () =>
                          onboardingNotifier.setHealthIssue(HealthIssue.none),
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      title: 'Knee',
                      selected: onboardingModel.healthIssue == HealthIssue.knee,
                      onTap: () =>
                          onboardingNotifier.setHealthIssue(HealthIssue.knee),
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      title: 'Hip Joints',
                      selected: onboardingModel.healthIssue == HealthIssue.hip,
                      onTap: () =>
                          onboardingNotifier.setHealthIssue(HealthIssue.hip),
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      title: 'Back or Hernia',
                      selected: onboardingModel.healthIssue == HealthIssue.back,
                      onTap: () =>
                          onboardingNotifier.setHealthIssue(HealthIssue.back),
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      title: 'Arms and Shoulders',
                      selected: onboardingModel.healthIssue == HealthIssue.arms,
                      onTap: () =>
                          onboardingNotifier.setHealthIssue(HealthIssue.arms),
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      title: 'Cant Do Jumps',
                      selected:
                          onboardingModel.healthIssue == HealthIssue.noJumps,
                      onTap: () => onboardingNotifier.setHealthIssue(
                        HealthIssue.noJumps,
                      ),
                    ),
                  ],
                ),
                BottomCTAButton(
                  text: 'Continue',
                  enabled: onboardingModel.healthIssue != null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EquipmentScreen(),
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

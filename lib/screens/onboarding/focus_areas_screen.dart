import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/fitness_level_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/multi_select_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class FocusAreasScreen extends ConsumerWidget {
  const FocusAreasScreen({super.key});

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
                const TopProgressBar(currentStep: 4, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'Choose your focus areas',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MultiSelectTile(
                      title: 'Full Body',
                      iconRight: Icons.accessibility_new,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.fullBody,
                      ),
                      onTap: () => onboardingNotifier.toggleFocusArea(
                        FocusArea.fullBody,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Chest',
                      iconRight: Icons.sports_gymnastics,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.chest,
                      ),
                      onTap: () =>
                          onboardingNotifier.toggleFocusArea(FocusArea.chest),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Back',
                      iconRight: Icons.sports_gymnastics,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.back,
                      ),
                      onTap: () =>
                          onboardingNotifier.toggleFocusArea(FocusArea.back),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Arms',
                      iconRight: Icons.fitness_center,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.arms,
                      ),
                      onTap: () =>
                          onboardingNotifier.toggleFocusArea(FocusArea.arms),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Shoulders',
                      iconRight: Icons.sports_gymnastics,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.shoulders,
                      ),
                      onTap: () => onboardingNotifier.toggleFocusArea(
                        FocusArea.shoulders,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Abs',
                      iconRight: Icons.sports_gymnastics,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.abs,
                      ),
                      onTap: () =>
                          onboardingNotifier.toggleFocusArea(FocusArea.abs),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Legs',
                      iconRight: Icons.sports_gymnastics,
                      selected: onboardingModel.focusAreas.contains(
                        FocusArea.legs,
                      ),
                      onTap: () =>
                          onboardingNotifier.toggleFocusArea(FocusArea.legs),
                    ),
                  ],
                ),
                BottomCTAButton(
                  text: 'Continue',
                  enabled: onboardingModel.focusAreas.isNotEmpty,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const FitnessLevelScreen(),
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

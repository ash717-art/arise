import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/onboarding_model.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/workout_frequency_screen.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/multi_select_tile.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class EquipmentScreen extends ConsumerWidget {
  const EquipmentScreen({super.key});

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
              const TopProgressBar(currentStep: 11, totalSteps: 13),
              const SizedBox(height: 30),
              Text('What equipment do you have?', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    MultiSelectTile(
                      title: 'None (Bodyweight)',
                      selected: onboardingModel.equipment.contains(Equipment.none),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.none),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Full gym',
                      selected: onboardingModel.equipment.contains(Equipment.fullGym),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.fullGym),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Barbells',
                      selected: onboardingModel.equipment.contains(Equipment.barbells),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.barbells),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Dumbbells',
                      selected: onboardingModel.equipment.contains(Equipment.dumbbells),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.dumbbells),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Kettlebells',
                      selected: onboardingModel.equipment.contains(Equipment.kettlebells),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.kettlebells),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectTile(
                      title: 'Machines',
                      selected: onboardingModel.equipment.contains(Equipment.machines),
                      onTap: () => onboardingNotifier.toggleEquipment(Equipment.machines),
                    ),
                  ],
                ),
              ),
              BottomCTAButton(
                text: 'Continue',
                enabled: onboardingModel.equipment.isNotEmpty,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkoutFrequencyScreen()));
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

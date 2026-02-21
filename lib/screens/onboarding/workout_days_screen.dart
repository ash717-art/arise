import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/summary_screen.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class WorkoutDaysScreen extends ConsumerWidget {
  const WorkoutDaysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopProgressBar(currentStep: 13, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'Select your workout days',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: days.map((day) {
                    final isSelected = onboardingModel.workoutDays.contains(
                      day,
                    );
                    return ChoiceChip(
                      label: Text(day),
                      selected: isSelected,
                      onSelected: (selected) {
                        onboardingNotifier.toggleWorkoutDay(day);
                      },
                      backgroundColor: AppTheme.tileBackground,
                      selectedColor: AppTheme.primaryAccent,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppTheme.primaryCtaText
                            : AppTheme.textPrimary,
                      ),
                    );
                  }).toList(),
                ),
                if (onboardingModel.workoutDays.length >
                    onboardingModel.workoutsPerWeek)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'You can select up to ${onboardingModel.workoutsPerWeek} days.',
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.tileBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Smart Reminders',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Switch(
                            value: onboardingModel.remindersEnabled,
                            onChanged: (value) =>
                                onboardingNotifier.setReminders(value),
                            activeTrackColor: AppTheme.primaryAccent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We\'ll send you reminders on your workout days to keep you on track.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BottomCTAButton(
                  text: 'Continue',
                  enabled:
                      onboardingModel.workoutDays.length <=
                          onboardingModel.workoutsPerWeek &&
                      onboardingModel.workoutDays.isNotEmpty,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SummaryScreen()),
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

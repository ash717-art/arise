import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/height_screen.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class TargetWeightScreen extends ConsumerWidget {
  const TargetWeightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final isKg = onboardingModel.weightUnit == 'kg';

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopProgressBar(currentStep: 8, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'What is your target weight?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: Text(
                        'kg',
                        style: TextStyle(
                          color: isKg
                              ? AppTheme.primaryAccent
                              : AppTheme.textSecondary,
                        ),
                      ),
                      onPressed: () => onboardingNotifier.setWeightUnit('kg'),
                    ),
                    CupertinoButton(
                      child: Text(
                        'lbs',
                        style: TextStyle(
                          color: !isKg
                              ? AppTheme.primaryAccent
                              : AppTheme.textSecondary,
                        ),
                      ),
                      onPressed: () => onboardingNotifier.setWeightUnit('lbs'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                      initialItem:
                          (isKg
                                  ? onboardingModel.targetWeight
                                  : onboardingModel.targetWeight * 2.20462)
                              .toInt() -
                          30,
                    ),
                    onSelectedItemChanged: (int index) {
                      double selectedValue = (index + 30).toDouble();
                      if (isKg) {
                        onboardingNotifier.setTargetWeight(selectedValue);
                      } else {
                        onboardingNotifier.setTargetWeight(
                          selectedValue / 2.20462,
                        );
                      }
                    },
                    children: List<Widget>.generate(200, (int index) {
                      return Center(
                        child: Text(
                          '${index + 30}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                BottomCTAButton(
                  text: 'Continue',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HeightScreen()),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/onboarding_provider.dart';
import 'package:myapp/screens/onboarding/health_issues_screen.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/top_progress_bar.dart';

class HeightScreen extends ConsumerWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingModel = ref.watch(onboardingProvider);
    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final isCm = onboardingModel.heightUnit == 'cm';

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopProgressBar(currentStep: 9, totalSteps: 13),
                const SizedBox(height: 30),
                Text(
                  'What is your height?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: Text(
                        'cm',
                        style: TextStyle(
                          color: isCm
                              ? AppTheme.primaryAccent
                              : AppTheme.textSecondary,
                        ),
                      ),
                      onPressed: () => onboardingNotifier.setHeightUnit('cm'),
                    ),
                    CupertinoButton(
                      child: Text(
                        'ft-in',
                        style: TextStyle(
                          color: !isCm
                              ? AppTheme.primaryAccent
                              : AppTheme.textSecondary,
                        ),
                      ),
                      onPressed: () =>
                          onboardingNotifier.setHeightUnit('ft-in'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: isCm
                      ? _buildCmPicker(
                          onboardingModel.height,
                          onboardingNotifier,
                        )
                      : _buildFtInPicker(onboardingModel.height, ref),
                ),
                BottomCTAButton(
                  text: 'Continue',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HealthIssuesScreen(),
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

  Widget _buildCmPicker(double height, OnboardingNotifier notifier) {
    return CupertinoPicker(
      itemExtent: 50,
      scrollController: FixedExtentScrollController(
        initialItem: height.toInt() - 120,
      ),
      onSelectedItemChanged: (int index) {
        notifier.setHeight((index + 120).toDouble());
      },
      children: List<Widget>.generate(131, (int index) {
        return Center(
          child: Text(
            '${index + 120}',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        );
      }),
    );
  }

  Widget _buildFtInPicker(double height, WidgetRef ref) {
    final notifier = ref.read(onboardingProvider.notifier);
    // Conversion: 1 ft = 30.48 cm, 1 inch = 2.54 cm
    final totalInches = height / 2.54;
    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();

    int initialFeet = feet >= 4 ? feet - 4 : 0;
    int initialInches = inches;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CupertinoPicker(
            itemExtent: 50,
            scrollController: FixedExtentScrollController(
              initialItem: initialFeet,
            ),
            onSelectedItemChanged: (int feetIndex) {
              final newFeet = feetIndex + 4;
              final currentInches =
                  ((ref.read(onboardingProvider).height / 2.54) % 12).round();
              final newHeight = (newFeet * 12 + currentInches) * 2.54;
              notifier.setHeight(newHeight);
            },
            children: List<Widget>.generate(5, (int index) {
              // 4ft to 8ft
              return Center(
                child: Text(
                  '${index + 4} ft',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            itemExtent: 50,
            scrollController: FixedExtentScrollController(
              initialItem: initialInches,
            ),
            onSelectedItemChanged: (int inchIndex) {
              final newInches = inchIndex;
              final currentFeet =
                  ((ref.read(onboardingProvider).height / 2.54) ~/ 12);
              final newHeight = (currentFeet * 12 + newInches) * 2.54;
              notifier.setHeight(newHeight);
            },
            children: List<Widget>.generate(12, (int index) {
              return Center(
                child: Text(
                  '$index in',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

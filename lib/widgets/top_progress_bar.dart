import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class TopProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const TopProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentStep / totalSteps).clamp(0.0, 1.0);
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

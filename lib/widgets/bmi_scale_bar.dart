import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class BmiScaleBar extends StatelessWidget {
  final double bmiValue;

  const BmiScaleBar({super.key, required this.bmiValue});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double position = _calculatePosition(totalWidth);

        return Column(
          children: [
            SizedBox(
              height: 40,
              child: Stack(
                children: [
                  Row(
                    children: [
                      _buildSegment('Underweight', Colors.blue, totalWidth * 0.2),
                      _buildSegment('Normal', Colors.green, totalWidth * 0.3),
                      _buildSegment('Overweight', Colors.orange, totalWidth * 0.2),
                      _buildSegment('Obese', Colors.red, totalWidth * 0.3),
                    ],
                  ),
                  Positioned(
                    left: position,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        const Icon(Icons.arrow_drop_down, color: AppTheme.textPrimary, size: 24),
                        Text(
                          bmiValue.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textPrimary)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSegment(String label, Color color, double width) {
    return Container(
      width: width,
      height: 10,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: Text(
          label, 
          style: TextStyle(color: Colors.white.withAlpha(0)), // Hide text but keep space
        )
      ),
    );
  }

  double _calculatePosition(double totalWidth) {
    double percentage;
    if (bmiValue < 18.5) {
      percentage = (bmiValue / 18.5) * 0.2;
    } else if (bmiValue < 25) {
      percentage = 0.2 + ((bmiValue - 18.5) / (25 - 18.5)) * 0.3;
    } else if (bmiValue < 30) {
      percentage = 0.5 + ((bmiValue - 25) / (30 - 25)) * 0.2;
    } else {
      percentage = 0.7 + ((bmiValue - 30) / (40 - 30)).clamp(0, 1) * 0.3;
    }
    return (totalWidth * percentage).clamp(0, totalWidth - 10); // clamp to avoid overflow
  }
}

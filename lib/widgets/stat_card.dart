import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final double value;
  final Color progressColor;
  final Color? color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.progressColor = AppTheme.primaryAccent,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            value.toStringAsFixed(0),
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: progressColor),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: AppTheme.subtleBorder,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

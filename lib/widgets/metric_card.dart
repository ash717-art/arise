import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final Widget child;

  const MetricCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

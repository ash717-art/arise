import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class StatPill extends StatelessWidget {
  final String label;
  final String value;

  const StatPill({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.tileBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class MacroPill extends StatelessWidget {
  final String title;
  final double value;
  final String unit;

  const MacroPill({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
        Text(
          '${value.round()}$unit',
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

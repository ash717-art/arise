import 'package:flutter/material.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/widgets/glass_container.dart';

class BottomCTAButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final bool enabled;

  const BottomCTAButton({
    super.key,
    required this.text,
    this.onTap,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final callback = onTap ?? onPressed;
    return GestureDetector(
      onTap: enabled ? callback : null,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: enabled
            ? Colors.blue.shade900.withAlpha((255 * 0.7).round())
            : AppColors.subtleBorder.withAlpha((255 * 0.5).round()),
        border: Border.all(
          color: enabled ? Colors.blue.shade800 : AppColors.subtleBorder,
          width: 1,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

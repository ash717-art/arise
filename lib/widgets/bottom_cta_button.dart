import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

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
    return ElevatedButton(
      onPressed: enabled ? callback : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? AppTheme.textPrimary : AppTheme.subtleBorder,
        foregroundColor: AppTheme.primaryCtaText,
      ),
      child: Text(text),
    );
  }
}

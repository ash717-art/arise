import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: subtitle != null ? 72 : 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.tileBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.primaryAccent : AppTheme.subtleBorder,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppTheme.textPrimary, size: 24),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: AppTheme.primaryAccent, size: 24),
          ],
        ),
      ),
    );
  }
}

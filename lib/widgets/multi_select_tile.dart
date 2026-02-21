import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class MultiSelectTile extends StatelessWidget {
  final String title;
  final IconData? iconRight;
  final bool selected;
  final VoidCallback onTap;

  const MultiSelectTile({
    super.key,
    required this.title,
    this.iconRight,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? AppTheme.selectedFill : AppTheme.tileBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.selectedBorder : AppTheme.subtleBorder,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (iconRight != null)
              Icon(iconRight, color: AppTheme.textSecondary, size: 28),
          ],
        ),
      ),
    );
  }
}

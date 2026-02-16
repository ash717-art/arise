import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class SyncModal extends StatelessWidget {
  final String title;
  final String text;
  final String? message;

  const SyncModal({
    super.key,
    this.title = 'NOTIFICATION',
    this.text = 'Syncing your data...',
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.tileBackgroundTransparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.subtleBorder),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.neonHighlightGreen,
                          shadows: [
                            const Shadow(
                              blurRadius: 10.0,
                              color: AppTheme.neonHighlightGreen,
                            ),
                          ],
                        ),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.successGreen),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSyncModal(BuildContext context, {required VoidCallback onSynced}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const SyncModal();
    },
  );

  await Future.delayed(const Duration(seconds: 2));
  if (context.mounted) {
    Navigator.of(context).pop(); // Dismiss the modal
  }
  onSynced(); // Navigate to the next screen
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/projection_line_chart.dart';
import 'package:myapp/widgets/sync_modal.dart';

class ProgramIntroScreen extends StatelessWidget {
  const ProgramIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final endDate = DateTime.now().add(const Duration(days: 90));
    final formattedEndDate = DateFormat.yMMMMd().format(endDate);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.backgroundStart, AppTheme.backgroundEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Subtle circular glow (like the reference)
          Positioned(
            right: -140,
            top: 160,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.primary.withAlpha(51), Colors.transparent],
                ),
              ),
            ),
          ),

          // Projection graph ghosted in the background
          Positioned(
            left: 16,
            right: 16,
            bottom: 120,
            child: Opacity(
              opacity: 0.55,
              child: ProjectionLineChart(
                height: 220,
                showLegend: false,
                showTitle: false,
                showRankLabels: true,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  const Text(
                    'Arise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The System will help you progress toward\nyour dream physique in 90 days.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 26),

                  Text(
                    'Become the best version of yourself by:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withAlpha(115),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Date chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withAlpha(26)),
                    ),
                    child: Text(
                      formattedEndDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),

                  _Bullet(text: 'Become more attractive and confident'),
                  const SizedBox(height: 14),
                  _Bullet(
                    text: 'Your physical strength will improve drastically',
                  ),
                  const SizedBox(height: 14),
                  _Bullet(text: 'You will feel more energized than ever'),
                  const SizedBox(height: 14),
                  _Bullet(text: 'Boost your self-worth'),

                  const Spacer(),

                  const Text(
                    "See what's possible",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),

                  BottomCTAButton(
                    text: 'Start My Program',
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const SyncModal(text: 'Syncing your data...'),
                      );
                      // Close modal
                      if (context.mounted) Navigator.of(context).pop();
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.success,
          ),
          child: const Icon(Icons.check, color: Colors.black, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

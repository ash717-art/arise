import 'package:flutter/material.dart';
import 'package:myapp/screens/program/projection_screen.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/stat_card.dart';

class PotentialStatsScreen extends StatelessWidget {
  const PotentialStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.backgroundStart, AppTheme.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Your Potential Stats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Based on your information, we believe you could\nimprove your stats in 3 months by completing a\ncustomised workout program.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 26),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.3,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      StatCard(title: 'Strength', value: 85, progressColor: AppColors.success),
                      StatCard(title: 'Vitality', value: 80, progressColor: AppColors.success),
                      StatCard(title: 'Agility', value: 78, progressColor: AppColors.success),
                      StatCard(title: 'Recovery', value: 82, progressColor: AppColors.success),
                    ],
                  ),
                ),

                BottomCTAButton(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ProjectionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

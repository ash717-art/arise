import 'package:flutter/material.dart';
import 'package:myapp/screens/stats/potential_stats_screen.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/stat_card.dart';

class CurrentStatsScreen extends StatelessWidget {
  const CurrentStatsScreen({super.key});

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
                  'Your Arise Stats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Based on your answers, this is your current Arise\nstats, which reflects your lifestyle and training\nhabits.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withAlpha(140),
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
                      StatCard(
                        title: 'Strength',
                        value: 12,
                        progressColor: AppColors.danger,
                      ),
                      StatCard(
                        title: 'Vitality',
                        value: 12,
                        progressColor: AppColors.danger,
                      ),
                      StatCard(
                        title: 'Agility',
                        value: 14,
                        progressColor: AppColors.danger,
                      ),
                      StatCard(
                        title: 'Recovery',
                        value: 12,
                        progressColor: AppColors.danger,
                      ),
                    ],
                  ),
                ),

                BottomCTAButton(
                  text: 'Show Potential',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PotentialStatsScreen(),
                      ),
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

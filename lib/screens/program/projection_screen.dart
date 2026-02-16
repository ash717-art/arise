import 'package:flutter/material.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/theme/theme.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/projection_line_chart.dart';
import '../onboarding/fingerprint_lockin_screen.dart';

class ProjectionScreen extends StatelessWidget {
  const ProjectionScreen({super.key});

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
                const SizedBox(height: 20),
                const Text(
                  'Give yourself just 90 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 22),
                const ProjectionLineChart(height: 260),
                const SizedBox(height: 22),

                _BenefitCard(
                  titleBold: 'Your ',
                  highlight: 'strength',
                  titleTail: ' will increase significantly',
                  subtitle: 'Progressive overload training will help you lift\nheavier weights and build lean muscle',
                ),
                const SizedBox(height: 14),
                _BenefitCard(
                  titleBold: "You'll have more ",
                  highlight: 'energy',
                  titleTail: '',
                  subtitle: "Better conditioning means you won't get tired\nduring daily activities",
                ),
                const SizedBox(height: 14),
                _BenefitCard(
                  titleBold: 'Your ',
                  highlight: 'confidence',
                  titleTail: ' will drastically improve',
                  subtitle: "As you transform your body, you'll feel\nempowered and unstoppable",
                ),

                const Spacer(),
                BottomCTAButton(
                  text: 'Unlock My Potential',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => FingerprintLockInScreen(onLockedIn: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      })),
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

class _BenefitCard extends StatelessWidget {
  final String titleBold;
  final String highlight;
  final String titleTail;
  final String subtitle;

  const _BenefitCard({
    required this.titleBold,
    required this.highlight,
    required this.titleTail,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success,
            ),
            child: const Icon(Icons.check, size: 18, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                    children: [
                      TextSpan(text: titleBold),
                      TextSpan(text: highlight, style: const TextStyle(color: AppColors.success)),
                      TextSpan(text: titleTail),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 13, height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
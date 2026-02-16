import 'package:flutter/material.dart';
import 'package:myapp/screens/onboarding/gender_screen.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/widgets/bottom_cta_button.dart';
import 'package:myapp/widgets/glass_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _showAcceptDialog(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'notification',
      barrierColor: Colors.black.withOpacity(0.72),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              borderRadius: 28,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'NOTIFICATION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.10)),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 16, height: 1.3, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: 'You have acquired the qualifications\n'),
                          TextSpan(text: 'to be a ', style: TextStyle(color: Colors.white)),
                          TextSpan(text: 'Player', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w900)),
                          TextSpan(text: '.\nWill you accept?'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: 160,
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white.withOpacity(0.35)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const GenderScreen()),
                        );
                      },
                      child: const Text(
                        'Accept',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Color(0xCC001524),
                  Color(0xE6002338),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    'ARISE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 58,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Level Up In Real Life',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  BottomCTAButton(
                    text: 'Get Started  »',
                    onPressed: () => _showAcceptDialog(context),
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

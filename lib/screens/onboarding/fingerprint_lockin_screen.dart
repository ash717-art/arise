import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/providers/progress_provider.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerprintLockInScreen extends ConsumerStatefulWidget {
  final VoidCallback? onLockedIn;
  const FingerprintLockInScreen({super.key, this.onLockedIn});

  @override
  ConsumerState<FingerprintLockInScreen> createState() =>
      _FingerprintLockInScreenState();
}

class _FingerprintLockInScreenState
    extends ConsumerState<FingerprintLockInScreen>
    with SingleTickerProviderStateMixin {
  static const _holdDuration = Duration(milliseconds: 1200);

  Timer? _timer;
  double _progress = 0.0;
  bool _holding = false;
  final TextEditingController _nameController = TextEditingController();
  String? _nameError;

  void _showNameRequired() {
    setState(() => _nameError = 'Enter your name first');
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('First enter your name'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
    HapticFeedback.vibrate();
  }

  void _startHold() {
    if (_holding) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showNameRequired();
      return;
    }
    setState(() => _nameError = null);
    _holding = true;
    HapticFeedback.mediumImpact();
    final start = DateTime.now();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (t) {
      final elapsed = DateTime.now().difference(start);
      final p = (elapsed.inMilliseconds / _holdDuration.inMilliseconds).clamp(
        0.0,
        1.0,
      );
      setState(() => _progress = p);

      if (p >= 1.0) {
        t.cancel();
        HapticFeedback.heavyImpact();
        ref.read(playerProgressProvider.notifier).resetProgress().then((_) {
          ref
              .read(playerProgressProvider.notifier)
              .setPlayerName(_nameController.text)
              .then((_) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboarding_complete', true);
            if (mounted) {
              if (widget.onLockedIn != null) {
                widget.onLockedIn!();
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              }
            }
          });
        });
      }
    });
  }

  void _cancelHold() {
    _timer?.cancel();
    _timer = null;
    if (!_holding) return;
    _holding = false;
    setState(() => _progress = 0.0);
    HapticFeedback.selectionClick();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Prefill name if already saved
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = ref.read(playerProgressProvider).valueOrNull;
      if (p != null && p.playerName.trim().isNotEmpty) {
        _nameController.text = p.playerName;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background art
          Image.asset('assets/images/lockin_bg.jpg', fit: BoxFit.cover),
          // Dark overlay + subtle blue tint
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Color(0xCC00121F),
                  Color(0xE6002033),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  const Text(
                    'Arise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'Are you ready\nto lock in?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 18),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.35,
                      ),
                      children: [
                        TextSpan(
                          text: 'WARNING',
                          style: TextStyle(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                          ),
                        ),
                        TextSpan(
                          text: " - You've seen the path ahead. Choose\n",
                        ),
                        TextSpan(text: 'to walk it, or remain where you are.'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x660B2236),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x3314324A)),
                    ),
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.w600,
                        ),
                        errorText: _nameError,
                        errorStyle: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onChanged: (_) {
                        if (_nameError != null) {
                          setState(() => _nameError = null);
                        }
                      },
                    ),
                  ),

                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (_nameController.text.trim().isEmpty) {
                        _showNameRequired();
                      }
                    },
                    onLongPressStart: (_) => _startHold(),
                    onLongPressEnd: (_) => _cancelHold(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: CircularProgressIndicator(
                                  value: _progress,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.white12,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                ),
                              ),
                              Icon(
                                Icons.fingerprint_rounded,
                                size: 72,
                                color: _holding
                                    ? AppColors.primary
                                    : Colors.white54,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Tap and hold to lock in',
                          style: TextStyle(color: Colors.white38, fontSize: 14),
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
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

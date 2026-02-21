import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/screens/analysis/analysis_complete_screen.dart';
import 'package:myapp/theme/theme.dart';

class SyncingDataScreen extends StatefulWidget {
  const SyncingDataScreen({super.key});

  @override
  State<SyncingDataScreen> createState() => _SyncingDataScreenState();
}

class _SyncingDataScreenState extends State<SyncingDataScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AnalysisCompleteScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        child: Center(
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
                      'NOTIFICATION',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Syncing your data...',
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.successGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _animation.value,
                        backgroundColor: AppTheme.subtleBorder,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.successGreen,
                        ),
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

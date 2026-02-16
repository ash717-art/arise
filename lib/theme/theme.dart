import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundStart = Color(0xFF070B12);
  static const Color backgroundEnd = Color(0xFF071B2A);
  static const Color primaryAccent = Color(0xFF2D8CFF);
  static const Color tileBackground = Color(0xFF0B2236);
  static const Color tileBackgroundTransparent = Color(0x800B2236);
  static const Color subtleBorder = Color(0xFF14324A);
  static const Color selectedFill = Color(0xFF1F5F3A);
  static const Color selectedBorder = Color(0xFF2E8B57);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA9B6C3);
  static const Color primaryCtaText = Color(0xFF0A1624);
  static const Color successGreen = Color(0xFF47B85A);
  static const Color neonHighlightGreen = Color(0xFF66FF88);
  static const Color dangerRed = Color(0xFFD83A3A);
  static const Color mutedGreyLine = Color(0x808A97A6); // ~50% opacity


  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundEnd,
    colorScheme: const ColorScheme.dark(
      primary: primaryAccent,
      secondary: primaryAccent,
      surface: backgroundEnd,
      onPrimary: textPrimary,
      onSecondary: textPrimary,
      onSurface: textPrimary,
      error: Colors.redAccent,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary),
      displayMedium: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: textPrimary),
      displaySmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: textPrimary),
      headlineMedium: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      headlineSmall: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
      titleLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary),
      bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.normal, color: textPrimary),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal, color: textSecondary),
      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal, color: textSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: textPrimary,
        foregroundColor: primaryCtaText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryAccent,
      inactiveTrackColor: tileBackground,
      thumbColor: primaryAccent,
      overlayColor: primaryAccent.withAlpha(51),
      trackHeight: 6.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    ),
  );
}

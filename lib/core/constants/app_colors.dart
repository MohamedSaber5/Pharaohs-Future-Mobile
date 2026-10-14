import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Pharaohs Future (مستقبل الفراعنة)
  // Royal Egyptian Gold & Deep Obsidian / Navy
  static const Color primaryGold = Color(0xFFC5A059);
  static const Color primaryGoldLight = Color(0xFFE5C378);
  static const Color primaryGoldDark = Color(0xFF9E7C38);

  static const Color deepNavy = Color(0xFF101928);
  static const Color secondaryNavy = Color(0xFF1E293B);
  static const Color cardNavy = Color(0xFF162032);

  // Accent & Status Colors
  static const Color accentCyan = Color(0xFF00B4D8);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Background & Surface Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Colors.white;
  static const Color backgroundDark = Color(0xFF0B111D);
  static const Color surfaceDark = Color(0xFF141E2F);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF26334D);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [primaryGoldLight, primaryGold, primaryGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient royalDarkGradient = LinearGradient(
    colors: [Color(0xFF101928), Color(0xFF0B111D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

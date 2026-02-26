import 'package:flutter/material.dart';

class WkAppColors {
  // Prevent instantiation
  WkAppColors._();

  // --- Brand Colors ---
  static const Color primary = Color(0xFF1A43BF); // Example: Deep Westerlund Blue
  static const Color secondary = Color(0xFF00C853); // Example: Action Green
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;

  // --- Primary Scale (Blue) ---
  static const Color primary50 = Color(0xFFE8EAF6);
  static const Color primary100 = Color(0xFFC5CAE9);
  static const Color primary300 = Color(0xFF7986CB);
  static const Color primary700 = Color(0xFF153699);
  static const Color primary900 = Color(0xFF0D215E);

  // --- Secondary Scale (Green) ---
  static const Color secondary50 = Color(0xFFE8F5E9);
  static const Color secondary100 = Color(0xFFC8E6C9);
  static const Color secondary300 = Color(0xFF81C784);
  static const Color secondary700 = Color(0xFF00A343);
  static const Color secondary900 = Color(0xFF00702E);

  // --- Status & Feedback ---
  static const Color info = Color(0xFF2196F3); // Blue
  static const Color danger = Color(0xFFD32F2F); // Red
  static const Color warning = Color(0xFFFFA000); // Amber
  static const Color success = Color(0xFF388E3C); // Green

  // --- Text & Hints ---
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color hint = Color(0xFF9E9E9E); // Classic grey hint text
  static const Color disabled = Color(0xFFBDBDBD);
}

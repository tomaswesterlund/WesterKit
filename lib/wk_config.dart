import 'package:flutter/material.dart';
import 'package:wester_kit/wk_app_colors.dart';

class WesterKit {
  static ThemeData createTheme(WkThemeConfig config) {
    return ThemeData(
      primaryColor: config.primary,
      scaffoldBackgroundColor: config.background,
      colorScheme: ColorScheme.fromSeed(seedColor: config.primary, secondary: config.secondary),
      appBarTheme: AppBarTheme(backgroundColor: config.primary),
    );
  }
}

class WkThemeConfig {
  final Color primary;
  final Color secondary;
  final Color background;

  const WkThemeConfig({
    this.primary = WkAppColors.primary,
    this.secondary = WkAppColors.secondary,
    this.background = WkAppColors.background,
  });
}

import 'package:flutter/material.dart';
import 'package:wester_kit/extensions/formatters/currency_formatter.dart';

class AmountText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final double? amount; // Added to track raw value for conditional coloring

  const AmountText(
    this.text, {
    this.fontSize = 48.0,
    this.color,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
    this.amount,
    super.key,
  });

  /// Factory for double values
  factory AmountText.fromDouble(
    double amount, {
    double fontSize = 48.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    Key? key,
  }) => AmountText(
    CurrencyFormatter.fromDouble(amount),
    key: key,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    textAlign: textAlign,
    amount: amount,
  );

  /// Factory for integer values
  factory AmountText.fromInt(
    int amount, {
    double fontSize = 48.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    Key? key,
  }) => AmountText(
    CurrencyFormatter.fromDouble(amount.toDouble()),
    key: key,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    textAlign: textAlign,
    amount: amount.toDouble(),
  );

  /// Factory for cent values
  factory AmountText.fromCents(
    int amount, {
    double fontSize = 48.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    Key? key,
  }) => AmountText(
    CurrencyFormatter.fromCents(amount),
    key: key,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    textAlign: textAlign,
    amount: amount / 100, // Normalize cents to double for comparison
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Logic for conditional coloring
    Color? effectiveColor = color;

    if (effectiveColor == null && amount != null) {
      if (amount! > 0) {
        effectiveColor = Colors.green; // Success
      } else if (amount! < 0) {
        effectiveColor = Colors.red; // Danger
      } else {
        effectiveColor = Colors.black; // Neutral zero
      }
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: effectiveColor ?? theme.textTheme.bodyLarge?.color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'NotoSansMono',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wester_kit/extensions/formatters/currency_formatter.dart';

class AmountText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const AmountText(
    this.text, {
    this.fontSize = 48.0,
    this.color,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
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
  }) =>
      AmountText(
        CurrencyFormatter.fromDouble(amount),
        key: key,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );

  /// Factory for integer values
  factory AmountText.fromInt(
    int amount, {
    double fontSize = 48.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    Key? key,
  }) =>
      AmountText(
        CurrencyFormatter.fromDouble(amount.toDouble()),
        key: key,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );

  /// Factory for cent values
  factory AmountText.fromCents(
    int amount, {
    double fontSize = 48.0,
    Color? color,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign? textAlign,
    Key? key,
  }) =>
      AmountText(
        CurrencyFormatter.fromCents(amount),
        key: key,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return FittedBox(
      fit: BoxFit.scaleDown,
      // Ensures the scaling stays consistent with your intended alignment
      alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color ?? theme.textTheme.bodyLarge?.color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          // Mandated for numeric data in your design system
          fontFamily: 'NotoSansMono', 
        ),
      ),
    );
  }
}
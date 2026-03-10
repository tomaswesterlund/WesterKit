import 'package:flutter/material.dart';
import 'package:wester_kit/extensions/formatters/currency_formatter.dart';

class AmountText extends StatelessWidget {
  final int amountInCents;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const AmountText({
    required this.amountInCents,
    this.fontSize = 48.0,
    this.color,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Logic for conditional coloring
    Color? effectiveColor = color;

    if (effectiveColor == null) {
      if (amountInCents > 0) {
        effectiveColor = Colors.green;
      } else if (amountInCents < 0) {
        effectiveColor = Colors.red;
      } else {
        effectiveColor = Colors.black;
      }
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
      child: Text(
        CurrencyFormatter.fromCents(amountInCents),
        textAlign: textAlign,
        style: TextStyle(
          color: effectiveColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'NotoSansMono',
        ),
      ),
    );
  }
}

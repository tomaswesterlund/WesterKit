import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;

  const BodyText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
  });

  /// Body Large: 18PX / 28PX LINE (Body Parrafo 01)
  factory BodyText.large(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        style: TextStyle(
          fontSize: 18,
          height: 28 / 18,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Body Medium: 16PX / 24PX LINE (Body Parrafo 02)
  factory BodyText.medium(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        style: TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Body Small: 14PX / 20PX LINE (Body Parrafo 03)
  factory BodyText.small(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  /// Caption / Tiny: 12PX / 16PX LINE (Overline)
  factory BodyText.tiny(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Key? key,
  }) =>
      BodyText(
        text,
        key: key,
        textAlign: textAlign,
        color: color,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: fontWeight ?? FontWeight.normal,
          // Note: Guide indicates Poppins for this specific size
          fontFamily: 'Poppins', 
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      text,
      textAlign: textAlign,
      style: style?.copyWith(
        color: color ?? theme.textTheme.bodyMedium?.color,
        // Inherits Raleway from theme for Large/Medium/Small
        fontFamily: style?.fontFamily ?? theme.textTheme.bodyMedium?.fontFamily,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class PhoneNumberInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;

  const PhoneNumberInputField({
    required this.label,
    this.hint = "(555) 000-0000",
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    super.key,
  });

  /// Formats raw digits into the visual mask for initial display
  String? _formatInitial(String? value) {
    if (value == null || value.isEmpty) return value;
    // If it's already formatted, return it; otherwise, format 10 digits
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return value;
    return "(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),

        // --- Standardized TextFormField ---
        TextFormField(
          initialValue: _formatInitial(initialValue),
          onChanged: (value) {
            // Strip formatting characters so the caller gets "5551231234"
            final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
            onChanged?.call(digitsOnly);
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
            PhoneInputFormatter(),
          ],
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontFamily: 'NotoSansMono'),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_outlined, color: colorScheme.primary),
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline, fontFamily: 'NotoSansMono'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: HeaderText.three(label),
        content: BodyText.medium(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: HeaderText.six('Entendido', color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (newValue.selection.baseOffset == 0) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');
      buffer.write(text[i]);
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final bool readOnly;

  const EmailInputField({
    required this.label,
    this.hint = "ejemplo@correo.com",
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.readOnly = false,
    super.key,
  });

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

        // --- Input Field ---
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          readOnly: readOnly,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,

          style: theme.textTheme.bodyMedium?.copyWith(color: readOnly ? colorScheme.outline : colorScheme.onSurface),

          // Email Specific Validation
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa un correo';
            }
            final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            ).hasMatch(value);
            return emailValid ? null : 'Ingresa un correo válido';
          },

          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(Icons.email_outlined, color: colorScheme.primary, size: 20),
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),

            // Standard Border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),

            // Focus Border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: readOnly ? colorScheme.outlineVariant : colorScheme.primary, width: 2),
            ),

            // Error Borders
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),

            filled: true,
            fillColor: readOnly ? colorScheme.surfaceVariant : colorScheme.surface,
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

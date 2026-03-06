import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(bool)? onValidationChanged; // Added this
  final bool isRequired;
  final String? helpText;
  final bool isReadonly;

  const EmailInputField({
    required this.label,
    this.hint = "ejemplo@correo.com",
    this.initialValue,
    this.onChanged,
    this.onValidationChanged, // Added this
    this.isRequired = false,
    this.helpText,
    this.isReadonly = false,
    super.key,
  });

  // Keep your logic separate for reuse
  bool _checkIfValid(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
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

        TextFormField(
          initialValue: initialValue,
          // Updated only this part to trigger the callback
          onChanged: (value) {
            onChanged?.call(value);
            onValidationChanged?.call(_checkIfValid(value));
          },
          readOnly: isReadonly,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,

          style: theme.textTheme.bodyMedium?.copyWith(
            color: isReadonly ? colorScheme.onSurfaceVariant.withOpacity(0.7) : colorScheme.onSurface,
          ),

          validator: (value) {
            if (isReadonly) return null;
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa un correo';
            }
            // Use the same logic here
            return _checkIfValid(value) ? null : 'Ingresa un correo válido';
          },

          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: isReadonly ? colorScheme.outline : colorScheme.primary,
              size: 20,
            ),
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: isReadonly ? colorScheme.outlineVariant : colorScheme.primary,
                width: isReadonly ? 1 : 2,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),

            filled: true,
            fillColor: isReadonly ? colorScheme.surfaceVariant.withOpacity(0.5) : colorScheme.surface,
          ),
        ),
      ],
    );
  }

  // Keeping your help dialog logic exactly as is
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

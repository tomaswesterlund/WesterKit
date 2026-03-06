import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  // Added this callback
  final Function(bool)? onValidationChanged;
  final bool isRequired;
  final String? helpText;
  final bool isReadonly;

  const EmailInputField({
    required this.label,
    this.hint = "ejemplo@correo.com",
    this.initialValue,
    this.onChanged,
    this.onValidationChanged, // Initialize here
    this.isRequired = false,
    this.helpText,
    this.isReadonly = false,
    super.key,
  });

  // Helper to centralize the regex logic
  bool _isValidEmail(String? value) {
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
          onChanged: (value) {
            // 1. Notify text changes
            onChanged?.call(value);

            // 2. Notify validation status
            if (onValidationChanged != null) {
              onValidationChanged!(_isValidEmail(value));
            }
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
            return _isValidEmail(value) ? null : 'Ingresa un correo válido';
          },
          // ... rest of your decoration code
        ),
      ],
    );
  }
}

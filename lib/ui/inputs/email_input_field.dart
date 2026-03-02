import 'package:flutter/material.dart';
import 'package:wester_kit/ui/texts/body_text.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final bool enabled;
  final Function(String)? onChanged;

  const EmailInputField({
    required this.label,
    this.hint = "example@email.com",
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: BodyText.medium(label, color: colorScheme.onSurface),
        ),

        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,

          style: theme.textTheme.bodyMedium?.copyWith(
            color: enabled ? colorScheme.onSurface : colorScheme.outline,
          ),

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu correo';
            }
            final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            ).hasMatch(value);
            return emailValid ? null : 'Ingresa un correo válido';
          },

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined, color: colorScheme.primary),
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            
            // Standard Borders
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            
            // Focus Border (Resipal Green)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            
            // Error Border (Resipal Danger/Terracotta)
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),

            filled: true,
            fillColor: enabled ? colorScheme.surface : colorScheme.surfaceVariant,
          ),
        ),
      ],
    );
  }
}
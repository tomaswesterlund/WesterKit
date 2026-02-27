import 'package:flutter/material.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';
import 'package:wester_kit/wk_app_colors.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label using H6 spec ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: BodyText.medium(label, color: WkAppColors.textPrimary),
        ),

        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,

          // Using Theme's bodyMedium (16px / 24 line) for input text
          style: theme.textTheme.bodyMedium?.copyWith(color: enabled ? Colors.black87 : Colors.grey.shade600),

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
            prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1A4644)),
            hintText: hint,
            // Using Theme's bodyMedium for hint
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Color(0xFF1A4644), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade50,
          ),
        ),
      ],
    );
  }
}

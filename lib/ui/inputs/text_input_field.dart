import 'package:flutter/material.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';
import 'package:wester_kit/wk_app_colors.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final bool readOnly;

  const TextInputField({
    required this.label,
    required this.hint,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText.six(label, color: WkAppColors.textPrimary),
              if (isRequired) BodyText.small(' *', color: Colors.red, fontWeight: FontWeight.bold),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(Icons.help_outline_rounded, size: 16, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ),

        // --- Input Field ---
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          // Body Medium (16px) for input text
          style: theme.textTheme.bodyMedium?.copyWith(color: readOnly ? Colors.grey.shade600 : Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            // Body Medium for hint text
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
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
              borderSide: BorderSide(color: readOnly ? Colors.grey.shade300 : const Color(0xFF1A4644), width: 2),
            ),
            filled: true,
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
          ),
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: HeaderText.three(label), // H3 for Dialog titles
        content: BodyText.medium(helpText!), // Body Medium for content
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: HeaderText.six('Entendido', color: Color(0xFF1A4644)),
          ),
        ],
      ),
    );
  }
}

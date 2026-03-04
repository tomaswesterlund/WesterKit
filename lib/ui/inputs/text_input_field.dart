import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

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
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(
          label: label,
          isRequired: isRequired,
          helpText: helpText,
          
          ),
        // --- Label Row ---
        // Padding(
        //   padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       BodyText.medium(label, color: colorScheme.onSurface),
        //       if (isRequired) 
        //         BodyText.small(' *', color: colorScheme.error, fontWeight: FontWeight.bold),
        //       if (helpText != null) ...[
        //         const SizedBox(width: 6),
        //         GestureDetector(
        //           onTap: () => _showHelpDialog(context),
        //           child: Icon(Icons.help_outline_rounded, size: 16, color: colorScheme.outline),
        //         ),
        //       ],
        //     ],
        //   ),
        // ),

        // --- Input Field ---
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: readOnly ? colorScheme.outline : colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            
            // Standard Border (Grey)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            
            // Focus Border (Resipal Green!)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: readOnly ? colorScheme.outlineVariant : colorScheme.primary, 
                width: 2,
              ),
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
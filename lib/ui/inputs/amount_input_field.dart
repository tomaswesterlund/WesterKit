import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wester_kit/wk_app_colors.dart';

class AmountInputField extends StatelessWidget {
  final String label;
  final String hint;
  final double? initialValue;
  final Function(double) onChanged;
  final bool isRequired;
  final String? helpText;
  final bool readOnly;
  final String currencySymbol;

  const AmountInputField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint = '0.00',
    this.initialValue,
    this.isRequired = false,
    this.helpText,
    this.readOnly = false,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                // Using H5 style from your typography guide (mapped to titleMedium)
                style: textTheme.titleMedium?.copyWith(color: WkAppColors.primary),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: textTheme.titleMedium?.copyWith(color: WkAppColors.danger, fontWeight: FontWeight.bold),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context, textTheme),
                  child: const Icon(Icons.help_outline_rounded, size: 16, color: WkAppColors.textSecondary),
                ),
              ],
            ],
          ),
        ),

        // --- Input Field ---
        TextFormField(
          initialValue: initialValue?.toStringAsFixed(2),
          readOnly: readOnly,
          onChanged: (value) {
            final double? amount = double.tryParse(value);
            if (amount != null) {
              onChanged(amount);
            }
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
          // Numeric content: Use Noto Sans Mono if configured in theme,
          // otherwise inherit Body Medium/Large scaling
          style: textTheme.bodyLarge?.copyWith(
            color: readOnly ? WkAppColors.textSecondary : WkAppColors.textPrimary,
            fontFamily: 'NotoSansMono', // Applying the numeric family from your guide
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currencySymbol,
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: WkAppColors.textSecondary),
              ),
            ),
            hintStyle: textTheme.bodyLarge?.copyWith(color: WkAppColors.hint),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: readOnly ? WkAppColors.grey100 : WkAppColors.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: WkAppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: readOnly ? WkAppColors.grey200 : WkAppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        content: Text(helpText!, style: textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Entendido',
              style: textTheme.labelLarge?.copyWith(color: WkAppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

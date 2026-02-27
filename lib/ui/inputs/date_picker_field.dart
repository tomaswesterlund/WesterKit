import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wester_kit/ui/texts/body_text.dart';
import 'package:wester_kit/ui/texts/header_text.dart';
import 'package:wester_kit/wk_app_colors.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRequired;
  final String? helpText;
  final Widget? prefixIcon;

  // Custom Color properties
  final Color primaryColor;
  final Color borderColor;

  const DatePickerField({
    required this.label,
    required this.onDateChanged,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.isRequired = false,
    this.helpText,
    this.prefixIcon,
    this.primaryColor = WkAppColors.primary, // Updated to Brand Primary
    this.borderColor = WkAppColors.border, // Updated to Brand Border
    super.key,
  });

  Future<void> _pickDate(BuildContext context) async {
    final theme = Theme.of(context);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: WkAppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');
    final displayString = selectedDate == null ? 'Seleccionar fecha' : dateFormat.format(selectedDate!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // H6 Style (14px Bold) per typography guide
              HeaderText.six(label, color: WkAppColors.textPrimary),
              if (isRequired) BodyText.small(' *', color: WkAppColors.danger, fontWeight: FontWeight.bold),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: const Icon(Icons.help_outline_rounded, size: 16, color: WkAppColors.grey500),
                ),
              ],
            ],
          ),
        ),

        // --- Input Decorator ---
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(20.0),
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: prefixIcon ?? Icon(Icons.calendar_month_rounded, size: 20, color: primaryColor),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              filled: true,
              fillColor: WkAppColors.surface,
            ),
            child: Text(
              displayString,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: selectedDate == null ? WkAppColors.grey500 : WkAppColors.textPrimary,
                fontFamily: selectedDate == null ? null : 'NotoSansMono',
              ),
            ),
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
        title: HeaderText.three(label),
        content: BodyText.medium(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: HeaderText.six('Entendido', color: primaryColor),
          ),
        ],
      ),
    );
  }
}

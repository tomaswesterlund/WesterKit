import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerField extends StatelessWidget {
  final String label;
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange?> onRangeSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateRangePickerField({
    required this.label,
    required this.onRangeSelected,
    this.selectedRange,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  Future<void> _pickDateRange(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      initialDateRange: selectedRange,
      builder: (context, child) {
        // This ensures the calendar dialog itself uses your Resipal Green
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary, // Resipal Green
              onPrimary: colorScheme.onPrimary, // White
              surface: colorScheme.surface,
              onSurface: colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onRangeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('dd/MM/yyyy');

    final displayString = selectedRange == null
        ? label
        : '${dateFormat.format(selectedRange!.start)} - ${dateFormat.format(selectedRange!.end)}';

    return InkWell(
      onTap: () => _pickDateRange(context),
      borderRadius: BorderRadius.circular(20.0),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today_rounded, 
            size: 20, 
            color: colorScheme.primary, // Resipal Green
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: colorScheme.surface,
        ),
        child: Text(
          displayString,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.0,
            color: selectedRange == null ? colorScheme.outline : colorScheme.onSurface,
            // Numbers and dates use Noto Sans Mono per guide
            fontFamily: selectedRange == null ? null : 'NotoSansMono',
          ),
        ),
      ),
    );
  }
}
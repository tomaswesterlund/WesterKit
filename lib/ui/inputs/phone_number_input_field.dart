import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wester_kit/ui/formatters.dart';
import 'package:wester_kit/ui/inputs/input_label.dart';

class PhoneNumberInputField extends StatefulWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;

  const PhoneNumberInputField({
    required this.label,
    this.hint = "(555) 000-0000",
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    super.key,
  });

  @override
  State<PhoneNumberInputField> createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  final List<String> _countryCodes = ['+1', '+46', '+52'];
  late String _selectedCountryCode;
  String _currentDigits = "";

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = _countryCodes.last; // Default to +52
    _currentDigits = PhoneFormatter.toRaw(widget.initialValue);
  }

  void _notifyChange() {
    // Standardized output: +525551234567
    widget.onChanged?.call('$_selectedCountryCode$_currentDigits');
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
          child: InputLabel(label: widget.label, isRequired: widget.isRequired, helpText: widget.helpText),
        ),
        TextFormField(
          initialValue: PhoneFormatter.toVisual(widget.initialValue),
          onChanged: (value) {
            _currentDigits = PhoneFormatter.toRaw(value);
            _notifyChange();
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
            PhoneInputFormatter(), // Custom visual formatter
          ],
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontFamily: 'NotoSansMono'),
          decoration: InputDecoration(
            prefixIcon: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: colorScheme.outlineVariant, width: 1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  icon: const Icon(Icons.arrow_drop_down, size: 20),
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedCountryCode = newValue);
                      _notifyChange();
                    }
                  },
                  items: _countryCodes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              ),
            ),
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline, fontFamily: 'NotoSansMono'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Reuse the central helper for the real-time visual mask
    final formatted = PhoneFormatter.toVisual(newValue.text);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

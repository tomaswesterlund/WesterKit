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
    this.hint = "55 0000 0000",
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
  final List<String> _dialCodes = ['+52', '+1'];
  late String _selectedDialCode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _selectedDialCode = _dialCodes.first; // Default to +52

    // Initialize controller with formatted national number if initialValue exists
    String initialText = "";
    if (widget.initialValue != null) {
      final String fullFormatted = PhoneFormatter.toDisplay(widget.initialValue);
      // Strip the dial code for the input field display
      initialText = fullFormatted.replaceFirst(_selectedDialCode, '').trim();
    }

    _controller = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOnChanged(String value) {
    final cleanDigits = value.replaceAll(RegExp(r'\D'), '');
    // Always send the combined E164 format to the parent (e.g., +525551234567)
    widget.onChanged?.call('$_selectedDialCode$cleanDigits');
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
          controller: _controller,
          onChanged: _handleOnChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _InputVisualFormatter(dialCode: _selectedDialCode),
          ],
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontFamily: 'NotoSansMono'),
          decoration: InputDecoration(
            prefixIcon: _buildCountrySelector(colorScheme, theme),
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

  Widget _buildCountrySelector(ColorScheme colorScheme, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: colorScheme.outlineVariant, width: 1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDialCode,
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => _selectedDialCode = newValue);
              _handleOnChanged(_controller.text);
            }
          },
          items: _dialCodes.map((code) => DropdownMenuItem(value: code, child: Text(code))).toList(),
        ),
      ),
    );
  }
}

/// Helper formatter for the input field that uses your PhoneFormatter logic
class _InputVisualFormatter extends TextInputFormatter {
  final String dialCode;
  _InputVisualFormatter({required this.dialCode});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Use your logic: combine dialCode + digits to get the formatted version
    final String fullNumber = '$dialCode${newValue.text.replaceAll(RegExp(r'\D'), '')}';
    final String formattedFull = PhoneFormatter.toDisplay(fullNumber);

    // Remove the dial code from the front to keep only the masked number in the field
    final String maskedLocal = formattedFull.replaceFirst(dialCode, '').trim();

    return TextEditingValue(
      text: maskedLocal,
      selection: TextSelection.collapsed(offset: maskedLocal.length),
    );
  }
}

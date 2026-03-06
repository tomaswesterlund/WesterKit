import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
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
  final Map<String, String> _countryRegions = {'+1': 'US', '+46': 'SE', '+52': 'MX'};

  late String _selectedDialCode;
  late String _regionCode;
  String _lastRawValue = "";

  @override
  void initState() {
    super.initState();
    _selectedDialCode = '+52';
    _regionCode = 'MX';
    _lastRawValue = widget.initialValue?.replaceAll(RegExp(r'\D'), '') ?? "";
  }

  void _handleOnChanged(String value) {
    // Only extract the numeric digits
    _lastRawValue = value.replaceAll(RegExp(r'\D'), '');
    widget.onChanged?.call('$_selectedDialCode$_lastRawValue');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Safety check: ensure libphonenumber is initialized
    final countries = CountryManager().countries;
    if (countries.isEmpty) {
      return const Center(child: Text("LibPhonenumber not initialized"));
    }

    final selectedCountry = countries.firstWhere((c) => c.countryCode == _regionCode, orElse: () => countries.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: widget.label, isRequired: widget.isRequired, helpText: widget.helpText),
        ),

        TextFormField(
          // Key ensures the formatter updates immediately when the region changes
          key: ValueKey(_regionCode),
          initialValue: widget.initialValue,
          onChanged: _handleOnChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LibPhonenumberTextFormatter(
              country: selectedCountry,
              phoneNumberFormat: PhoneNumberFormat.national,
              inputContainsCountryCode: false,
            ),
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
              setState(() {
                _selectedDialCode = newValue;
                _regionCode = _countryRegions[newValue] ?? 'MX';
              });
              // Send updated full number with new dial code
              widget.onChanged?.call('$_selectedDialCode$_lastRawValue');
            }
          },
          items: _countryRegions.keys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}

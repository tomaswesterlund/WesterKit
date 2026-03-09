import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';

class EntityDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? helpText;

  const EntityDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.value,
    this.isRequired = false,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),

        // --- Dropdown Field ---
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: colorScheme.outline),
          dropdownColor: colorScheme.surface,
          style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(value: item, child: Text(itemLabelBuilder(item)));
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return items.map((T item) {
              return Text(itemLabelBuilder(item), overflow: TextOverflow.ellipsis);
            }).toList();
          },
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
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Entendido', style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

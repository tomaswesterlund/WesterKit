import 'package:flutter/material.dart';

/// A premium, themed dropdown field for Westerlund Solutions projects.
class DropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownFieldItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? helpText;

  const DropdownField({
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.isRequired = false,
    this.helpText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

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
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(
                    Icons.help_outline_rounded, 
                    size: 16, 
                    color: theme.hintColor,
                  ),
                ),
              ],
            ],
          ),
        ),

        // --- Dropdown Field ---
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.hintColor),
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: theme.dividerColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: theme.dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item.value,
              child: Text(item.label),
            );
          }).toList(),
          // Ensures long text is truncated gracefully when selected
          selectedItemBuilder: (BuildContext context) {
            return items.map((item) {
              return Text(
                item.label,
                overflow: TextOverflow.ellipsis,
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Entendido', 
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownFieldItem<T> {
  final T value;
  final String label;

  const DropdownFieldItem({
    required this.value,
    required this.label,
  });
}
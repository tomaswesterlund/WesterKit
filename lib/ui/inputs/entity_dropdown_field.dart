import 'package:flutter/material.dart';
import 'package:wester_kit/wk_app_colors.dart';

class EntityDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder; // The logic to show the name
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
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: WkAppColors.textPrimary),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: WkAppColors.danger, fontWeight: FontWeight.bold),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: const Icon(Icons.help_outline_rounded, size: 16, color: WkAppColors.hint),
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
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: WkAppColors.hint),
          dropdownColor: WkAppColors.surface,
          style: const TextStyle(color: WkAppColors.textPrimary, fontSize: 16),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            filled: true,
            fillColor: WkAppColors.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: WkAppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: WkAppColors.primary, width: 2),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido', style: TextStyle(color: WkAppColors.primary)),
          ),
        ],
      ),
    );
  }
}

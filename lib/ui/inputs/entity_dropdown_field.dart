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
  final bool readOnly; // Nuevo parámetro

  const EntityDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.value,
    this.isRequired = false,
    this.helpText,
    this.readOnly = false, // Por defecto es falso
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
          // Si es readOnly, pasamos null a onChanged para deshabilitar el dropdown
          onChanged: readOnly ? null : onChanged,
          isExpanded: true,
          // Ocultamos o atenuamos el icono si es solo lectura
          icon: Icon(
            Icons.keyboard_arrow_down_rounded, 
            color: readOnly ? colorScheme.outlineVariant : colorScheme.outline,
          ),
          dropdownColor: colorScheme.surface,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: readOnly ? colorScheme.onSurface.withOpacity(0.6) : colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            filled: true,
            // Fondo ligeramente grisáceo si es readonly para indicar bloqueo
            fillColor: readOnly ? colorScheme.surfaceVariant.withOpacity(0.3) : colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: readOnly ? colorScheme.outlineVariant : colorScheme.primary, 
                width: readOnly ? 1 : 2,
              ),
            ),
            // Deshabilitamos el hover y feedback visual si es readonly
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(value: item, child: Text(itemLabelBuilder(item)));
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return items.map((T item) {
              return Text(
                itemLabelBuilder(item), 
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: readOnly ? colorScheme.onSurface.withOpacity(0.8) : colorScheme.onSurface,
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  // ... (mismo código para _showHelpDialog)
}
import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart'; // Asegúrate de importar tus componentes base

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({required this.label, required this.value, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icono con fondo sutil para que destaque
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: colorScheme.primary, size: 20),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Valor numérico con la fuente Mono del sistema
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  fontFamily: 'NotoSansMono', // Prioridad para datos financieros/numéricos
                ),
              ),
              const SizedBox(height: 2),
              // Etiqueta usando el estilo Overline
              OverlineText(label, color: colorScheme.outline),
            ],
          ),
        ],
      ),
    );
  }
}

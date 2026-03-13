import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
    required this.label, 
    required this.value, 
    required this.icon, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      // Padding interno para maximizar el área de los elementos
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24), // Bordes más suaves
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Etiqueta en la parte superior
          OverlineText(
            label.toUpperCase(), 
            color: colorScheme.outline,
          ),
          
          const Spacer(), // Empuja el contenido hacia el centro/abajo

          // 2. Body: Icono y Valor en una fila impactante
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono de mayor tamaño
              Icon(
                icon, 
                color: colorScheme.primary, 
                size: 32, // Tamaño incrementado
              ),
              const SizedBox(width: 8),
              
              // Valor numérico dominante
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900, // Extra Bold para impacto
                      color: colorScheme.onSurface,
                      letterSpacing: -1,
                      fontFamily: 'NotoSansMono',
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4), // Espacio final para balance
        ],
      ),
    );
  }
}
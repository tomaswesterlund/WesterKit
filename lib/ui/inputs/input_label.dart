import 'package:flutter/material.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final String? description;
  final String? helpText;
  final bool isRequired;

  const InputLabel({required this.label, this.description, this.helpText, this.isRequired = false, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderText.six(label, color: colorScheme.primary),
            if (isRequired)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '*',
                  style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error, fontWeight: FontWeight.bold),
                ),
              ),
            if (helpText != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showHelpDialog(context),
                child: Icon(Icons.help_outline_rounded, size: 18, color: colorScheme.outline),
              ),
            ],
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: 6.0),
          Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(label),
        content: Text(helpText!),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))],
      ),
    );
  }
}

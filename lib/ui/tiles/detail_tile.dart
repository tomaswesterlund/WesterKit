import 'package:flutter/material.dart';

/// A clean, structured tile for displaying labeled data points.
/// Part of the WesterKit library.
class DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const DetailTile({super.key, required this.icon, required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    // Falls back to the theme's colorScheme.secondary if no color is provided.
    // This is the standard way to replace "BaseAppColors.secondary"
    final Color iconColor = color ?? Theme.of(context).colorScheme.secondary;

    return ListTile(
      contentPadding: EdgeInsets.zero, // Often better for custom UI alignment
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}

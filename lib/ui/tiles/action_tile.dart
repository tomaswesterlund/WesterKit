import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const ActionTile({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: DefaultCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            
            // Title
            Expanded(
              child: BodyText.medium(
                title,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Notification Badge
            if (count > 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],

            // Navigation Indicator
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: colorScheme.outline.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
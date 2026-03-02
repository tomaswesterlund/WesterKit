import 'package:flutter/material.dart';

class SuccessButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool canSubmit;
  final bool isSubmitting;
  final IconData? icon;

  const SuccessButton({
    required this.label,
    required this.onPressed,
    this.canSubmit = true,
    this.isSubmitting = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Determine if the button should actually be clickable
    final bool isEnabled = canSubmit && !isSubmitting && onPressed != null;

    // Use tertiary or a custom success color from the scheme
    // If your ColorScheme mapping has 'success' colors, we use those here
    final baseColor = colorScheme.tertiaryContainer.withOpacity(1.0).value == colorScheme.surface.value 
        ? Colors.green.shade700 // Fallback if tertiary isn't set
        : colorScheme.tertiary; 

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: baseColor,
        foregroundColor: colorScheme.onTertiary,
        disabledBackgroundColor: baseColor.withOpacity(0.3),
        disabledForegroundColor: colorScheme.onTertiary.withOpacity(0.6),
        elevation: isEnabled ? 4 : 0,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isSubmitting
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onTertiary),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20), 
                    const SizedBox(width: 8)
                  ],
                  Text(
                    label, 
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      letterSpacing: 1.1,
                      color: isEnabled ? colorScheme.onTertiary : colorScheme.onTertiary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
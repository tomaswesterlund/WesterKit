import 'package:flutter/material.dart';
import 'package:wester_kit/wk_app_colors.dart';

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
    // Determine if the button should actually be clickable
    final bool isEnabled = canSubmit && !isSubmitting && onPressed != null;

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: WkAppColors.success,
        foregroundColor: Colors.white,
        disabledBackgroundColor: WkAppColors.success.withOpacity(0.3),
        disabledForegroundColor: Colors.white.withOpacity(0.6),
        elevation: isEnabled ? 4 : 0,
        shadowColor: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min, // Better for flexible layouts
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                ],
              ),
      ),
    );
  }
}

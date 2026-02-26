import 'package:flutter/material.dart';

/// A sleek, centered loading view that adapts to the app's theme.
/// Part of the WesterKit library.
class LoadingView extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? logo; // Allows passing a custom logo per project

  const LoadingView({this.title = 'Cargando información...', this.description, this.logo, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible logo section: if no logo is passed, it remains empty
            if (logo != null) ...[Opacity(opacity: 0.8, child: logo!), const SizedBox(height: 40)],

            // A sleek, thin progress bar using theme colors
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                backgroundColor: colorScheme.surfaceVariant, // Standalone alternative
                color: colorScheme.secondary,
                minHeight: 2,
              ),
            ),
            const SizedBox(height: 24),

            // Title using the theme's Headline style
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            // Description using the theme's Body style
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

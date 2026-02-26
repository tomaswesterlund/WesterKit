import 'package:flutter/material.dart';

/// A sleek preview card for receipts or documents.
/// Accepts a future for the image URL to remain service-agnostic.
class ReceiptPreview extends StatelessWidget {
  /// A future that resolves to the image URL (e.g., a signed URL).
  final Future<String>? imageUrlFuture;
  
  /// Or a direct URL if already available.
  final String? imageUrl;
  
  final double height;
  final String errorText;

  const ReceiptPreview({
    this.imageUrlFuture,
    this.imageUrl,
    this.height = 300,
    this.errorText = 'No se pudo cargar el comprobante',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // If a direct URL is provided, skip the FutureBuilder
    if (imageUrl != null) {
      return _NetworkImage(url: imageUrl!, height: height, errorText: errorText);
    }

    // If a Future is provided, wait for resolution
    if (imageUrlFuture != null) {
      return FutureBuilder<String>(
        future: imageUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: height,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return _ErrorState(height: 120, text: errorText);
          }

          return _NetworkImage(url: snapshot.data!, height: height, errorText: errorText);
        },
      );
    }

    return _ErrorState(height: 120, text: errorText);
  }
}

/// Internal helper for the Image.network logic
class _NetworkImage extends StatelessWidget {
  final String url;
  final double height;
  final String errorText;

  const _NetworkImage({required this.url, required this.height, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => _ErrorState(height: 120, text: errorText),
    );
  }
}

/// Internal helper for the Error UI
class _ErrorState extends StatelessWidget {
  final double height;
  final String text;

  const _ErrorState({required this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      color: theme.disabledColor.withOpacity(0.05),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: theme.disabledColor, size: 40),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(color: theme.disabledColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
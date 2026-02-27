// import 'dart:io';

// import 'package:flutter/material.dart';

// class ImagePreview extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onDelete;
//   const ImagePreview({super.key, required this.imagePath, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 200,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover),
//           ),
//         ),
//         Positioned(
//           top: 8,
//           right: 8,
//           child: GestureDetector(
//             onTap: onDelete,
//             child: const CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: 15,
//               child: Icon(Icons.close, size: 18, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final Future<String>? imageUrlFuture;
  final String? imageUrl;
  final double height;
  final String errorText;

  /// Callback to handle image removal
  final VoidCallback? onRemove;

  const ImagePreview({
    this.imageUrlFuture,
    this.imageUrl,
    this.height = 300,
    this.errorText = 'No se pudo cargar el comprobante',
    this.onRemove, // Added property
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Card(
          elevation: 0,
          margin: EdgeInsets.zero, // Important for the stack alignment
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
          ),
          child: _buildContent(context),
        ),

        // Remove button overlay
        if (onRemove != null)
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent black
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded, size: 20, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (imageUrl != null) {
      return _NetworkImage(url: imageUrl!, height: height, errorText: errorText);
    }

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

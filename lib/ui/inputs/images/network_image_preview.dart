import 'package:flutter/material.dart' hide NetworkImage;
import 'package:wester_kit/ui/inputs/images/base_image_preview.dart';
import 'package:wester_kit/ui/inputs/images/image_error_state.dart';
import 'package:wester_kit/ui/inputs/images/network_image.dart';

class NetworkImagePreview extends StatelessWidget {
  final String? imageUrl;
  final Future<String>? imageUrlFuture;
  final double height;
  final String errorText;
  final VoidCallback? onRemove;

  const NetworkImagePreview({
    this.imageUrl,
    this.imageUrlFuture,
    this.height = 300,
    this.errorText = 'No se pudo cargar la imagen',
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImagePreview(height: height, onRemove: onRemove, child: _buildContent());
  }

  Widget _buildContent() {
    if (imageUrl != null) {
      return NetworkImage(url: imageUrl!, height: height, errorText: errorText);
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
            return ImageErrorState(height: 120, text: errorText);
          }

          return NetworkImage(url: snapshot.data!, height: height, errorText: errorText);
        },
      );
    }

    return ImageErrorState(height: 120, text: errorText);
  }
}

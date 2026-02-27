import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/images/image_error_state.dart';

class NetworkImage extends StatelessWidget {
  final String url;
  final double height;
  final String errorText;

  const NetworkImage({required this.url, required this.height, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => ImageErrorState(height: 120, text: errorText),
    );
  }
}

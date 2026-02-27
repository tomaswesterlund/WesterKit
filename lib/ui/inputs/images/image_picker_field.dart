import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wester_kit/ui/inputs/images/image_picker_buttons.dart';
import 'package:wester_kit/ui/inputs/images/image_preview.dart';

class ImagePickerField extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback? onRemove; // Useful for resetting the form

  const ImagePickerField({
    required this.imageFile,
    required this.onCamera,
    required this.onGallery,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: imageFile != null
          ? ImagePreview(
              key: const ValueKey('preview'),
              imageUrl: imageFile!.path,
              onRemove: onRemove, // Pass a way to delete the photo
            )
          : ImagePickerButtons(
              key: const ValueKey('picker'),
              onCamera: onCamera,
              onGallery: onGallery,
            ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class MediaButton extends StatelessWidget {
  final Function(File image) onImageSelected;

  const MediaButton({super.key, required this.onImageSelected});

  Future<void> _pickFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _pickFromCamera(context),
      icon: const Icon(Icons.camera_alt),
      label: const Text("Take a photo"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        fixedSize: const Size(365, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

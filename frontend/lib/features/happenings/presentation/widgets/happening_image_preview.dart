import 'dart:io';
import 'package:flutter/material.dart';

class HappeningImagePreview extends StatelessWidget {
  final File? imageFile;

  const HappeningImagePreview({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      return const Text("No media selected");
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        imageFile!,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

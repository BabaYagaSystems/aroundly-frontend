import 'package:flutter/material.dart';
import 'package:frontend/shared/themes/app_colors.dart';

class MediaButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MediaButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.camera_alt),
      label: const Text("Take a photo"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        fixedSize: const Size(365, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

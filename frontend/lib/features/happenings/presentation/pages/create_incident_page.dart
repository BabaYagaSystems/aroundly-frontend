import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/features/happenings/presentation/widgets/create_happening_field.dart';
import 'package:frontend/features/happenings/presentation/widgets/happening_description_field.dart';
import 'package:frontend/features/happenings/presentation/widgets/happening_image_preview.dart';
import 'package:frontend/features/happenings/presentation/widgets/media_button.dart';
import 'package:frontend/shared/widgets/my_button.dart';

class CreateIncidentPage extends StatefulWidget {
  const CreateIncidentPage({super.key});

  @override
  State<CreateIncidentPage> createState() => _CreateIncidentPageState();
}

class _CreateIncidentPageState extends State<CreateIncidentPage> {
  File? _capturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 18),
            CreateHappeningField(),
            const SizedBox(height: 18),
            HappeningDescriptionField(),
            const SizedBox(height: 18),
            MediaButton(
              onImageSelected: (file) {
                setState(() => _capturedImage = file);
              },
            ),
            const SizedBox(height: 12),
            HappeningImagePreview(imageFile: _capturedImage),
            const SizedBox(height: 18),
            MyButton(btnText: 'Post', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

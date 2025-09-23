import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/happenings/presentation/widgets/create_happening_field.dart';
import 'package:frontend/features/happenings/presentation/widgets/happening_description_field.dart';
import 'package:frontend/features/happenings/presentation/widgets/happening_image_preview.dart';
import 'package:frontend/features/happenings/presentation/widgets/media_button.dart';
import 'package:frontend/shared/widgets/my_button.dart';

import '../bloc/create_incident_bloc.dart';

class CreateIncidentPage extends StatelessWidget {
  const CreateIncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: const Text('Create Incident'),
      ),
      body: BlocConsumer<CreateIncidentBloc, CreateIncidentState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Incident created successfully')),
            );
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          final bloc = context.read<CreateIncidentBloc>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 18),

                // TITLE
                CreateHappeningField(
                  initialValue: state.title,
                  onChanged: (v) => bloc.add(TitleChanged(v)),
                ),

                const SizedBox(height: 18),

                // DESCRIPTION
                HappeningDescriptionField(
                  initialValue: state.description,
                  onChanged: (v) => bloc.add(DescriptionChanged(v)),
                ),

                const SizedBox(height: 18),

                // LOCATION
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: state.submitting
                        ? null
                        : () => bloc.add(UseCurrentLocationPressed()),
                    icon: const Icon(Icons.my_location),
                    label: Text(
                      (state.lat == null || state.lon == null)
                          ? 'Use my location'
                          : 'Location: ${state.lat!.toStringAsFixed(5)}, ${state.lon!.toStringAsFixed(5)}',
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // CAMERA (only)
                MediaButton(
                  onPressed: state.submitting
                      ? null
                      : () => bloc.add(PickImageFromCameraPressed()),
                ),

                const SizedBox(height: 12),

                // IMAGE PREVIEW (from bloc state)
                HappeningImagePreview(
                  imageFile: state.image == null
                      ? null
                      : File(state.image!.path),
                ),

                const Spacer(),

                // SUBMIT
                MyButton(
                  btnText: state.submitting ? 'Posting…' : 'Post',
                  onPressed: (state.isValid && !state.submitting)
                      ? () => bloc.add(SubmitPressed())
                      : null,
                ),
                const SizedBox(height: 18),
              ],
            ),
          );
        },
      ),
    );
  }
}

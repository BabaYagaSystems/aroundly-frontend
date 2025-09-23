import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/incident.dart';
import '../../domain/entities/incident_media.dart';
import '../../domain/usecases/create_incident_usecase.dart';

part 'create_incident_event.dart';
part 'create_incident_state.dart';

class CreateIncidentBloc
    extends Bloc<CreateIncidentEvent, CreateIncidentState> {
  final CreateIncidentUseCase useCase;
  final ImagePicker _picker;

  CreateIncidentBloc(this.useCase)
    : _picker = ImagePicker(),
      super(const CreateIncidentState()) {
    on<TitleChanged>(
      (e, emit) => emit(state.copyWith(title: e.value, clearError: true)),
    );
    on<DescriptionChanged>(
      (e, emit) => emit(state.copyWith(description: e.value, clearError: true)),
    );
    on<PickImageFromCameraPressed>(_onPickImage);
    on<UseCurrentLocationPressed>(_onUseLocation);
    on<SubmitPressed>(_onSubmit);
  }

  Future<void> _onPickImage(
    PickImageFromCameraPressed e,
    Emitter<CreateIncidentState> emit,
  ) async {
    try {
      final img = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (img != null) emit(state.copyWith(image: img, clearError: true));
    } catch (err) {
      emit(state.copyWith(error: 'Failed to open camera: $err'));
    }
  }

  Future<void> _onUseLocation(
    UseCurrentLocationPressed e,
    Emitter<CreateIncidentState> emit,
  ) async {
    try {
      final perm = await Geolocator.checkPermission();
      LocationPermission finalPerm = perm;
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        finalPerm = await Geolocator.requestPermission();
      }
      if (finalPerm == LocationPermission.denied ||
          finalPerm == LocationPermission.deniedForever) {
        emit(state.copyWith(error: 'Location permission denied'));
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        // desiredAccuracy: LocationAccuracy.high,
      );
      emit(
        state.copyWith(lat: pos.latitude, lon: pos.longitude, clearError: true),
      );
    } catch (err) {
      emit(state.copyWith(error: 'Failed to get location: $err'));
    }
  }

  Future<void> _onSubmit(
    SubmitPressed e,
    Emitter<CreateIncidentState> emit,
  ) async {
    if (!state.isValid) {
      emit(
        state.copyWith(
          error:
              'Please complete all fields (title, description, photo, location).',
        ),
      );
      return;
    }
    emit(state.copyWith(submitting: true, clearError: true, success: false));

    try {
      // encode image to base64 data URL
      final fileBytes = await state.image!.readAsBytes();
      // Try to infer content type from path
      final isPng = state.image!.path.toLowerCase().endsWith('.png');
      final contentType = isPng ? 'image/png' : 'image/jpeg';
      final dataUrl = 'data:$contentType;base64,${base64Encode(fileBytes)}';

      final incident = Incident(
        title: state.title.trim(),
        description: state.description.trim(),
        lat: state.lat!,
        lon: state.lon!,
        media: [
          IncidentMedia(kind: 'IMAGE', contentType: contentType, uri: dataUrl),
        ],
      );

      final resp = await useCase(incident);
      emit(state.copyWith(submitting: false, success: true));
    } catch (err) {
      emit(
        state.copyWith(
          submitting: false,
          error: err.toString(),
          success: false,
        ),
      );
    }
  }
}

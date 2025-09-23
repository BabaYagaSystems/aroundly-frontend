part of 'create_incident_bloc.dart';

class CreateIncidentState extends Equatable {
  final String title;
  final String description;
  final double? lat;
  final double? lon;
  final XFile? image;
  final bool submitting;
  final String? error;
  final bool success;

  const CreateIncidentState({
    this.title = '',
    this.description = '',
    this.lat,
    this.lon,
    this.image,
    this.submitting = false,
    this.error,
    this.success = false,
  });

  bool get isValid =>
      title.trim().isNotEmpty &&
      description.trim().isNotEmpty &&
      lat != null &&
      lon != null &&
      image != null;

  CreateIncidentState copyWith({
    String? title,
    String? description,
    double? lat,
    double? lon,
    XFile? image,
    bool? submitting,
    String? error,
    bool? success,
    bool clearError = false,
  }) => CreateIncidentState(
    title: title ?? this.title,
    description: description ?? this.description,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    image: image ?? this.image,
    submitting: submitting ?? this.submitting,
    error: clearError ? null : (error ?? this.error),
    success: success ?? this.success,
  );

  @override
  List<Object?> get props => [
    title,
    description,
    lat,
    lon,
    image,
    submitting,
    error,
    success,
  ];
}

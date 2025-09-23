part of 'create_incident_bloc.dart';

abstract class CreateIncidentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TitleChanged extends CreateIncidentEvent {
  final String value;
  TitleChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class DescriptionChanged extends CreateIncidentEvent {
  final String value;
  DescriptionChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class PickImageFromCameraPressed extends CreateIncidentEvent {}

class UseCurrentLocationPressed extends CreateIncidentEvent {}

class SubmitPressed extends CreateIncidentEvent {}

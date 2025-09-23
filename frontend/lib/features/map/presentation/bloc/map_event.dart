part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapStarted extends MapEvent {}

class MapRadiusChanged extends MapEvent {
  final int radiusMeters; // 2000, 5000, 10000, 15000
  MapRadiusChanged(this.radiusMeters);
  @override
  List<Object?> get props => [radiusMeters];
}

class MapRadiusApplied extends MapEvent {}

class MapRecenterRequested extends MapEvent {}

class MapIncidentTapped extends MapEvent {
  final int incidentId;
  MapIncidentTapped(this.incidentId);
  @override
  List<Object?> get props => [incidentId];
}

class MapPreviewDismissed extends MapEvent {}

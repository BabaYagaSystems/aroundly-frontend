import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/incident_preview.dart';
import '../../domain/entities/nearby_incident.dart';
import '../../domain/usecases/get_incident_preview_usecase.dart';
import '../../domain/usecases/get_nearby_incidents_usecase.dart';

// entities + usecases imports assumed

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetNearbyIncidentsUseCase getNearby;
  final GetIncidentPreviewUseCase getPreview;

  StreamSubscription<Position>? _posSub;

  MapBloc({required this.getNearby, required this.getPreview})
    : super(const MapState()) {
    on<MapStarted>(_onStarted);
    on<MapRadiusChanged>(_onRadiusChanged);
    on<MapRadiusApplied>(_onRadiusApplied);
    on<MapRecenterRequested>(_onRecenterRequested);
    on<MapIncidentTapped>(_onIncidentTapped);
    on<MapPreviewDismissed>((e, emit) => emit(state.copyWith(selected: null)));
  }

  Future<void> _onStarted(MapStarted e, Emitter<MapState> emit) async {
    // request permission and start stream
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      emit(state.copyWith(error: 'Location permission denied'));
      return;
    }

    _posSub?.cancel();
    _posSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 50,
          ),
        ).listen((p) async {
          final lat = p.latitude;
          final lon = p.longitude;
          emit(
            state.copyWith(
              userLat: lat,
              userLon: lon,
              lastCameraToUser: DateTime.now(),
            ),
          );

          // fetch nearby if we have a radius
          if (state.radiusMeters != null) {
            try {
              final items = await getNearby(
                lat: lat,
                lon: lon,
                radiusMeters: state.radiusMeters!,
              );
              emit(state.copyWith(nearby: items, error: null));
            } catch (err) {
              emit(state.copyWith(error: err.toString()));
            }
          }
        });
  }

  Future<void> _onRadiusChanged(
    MapRadiusChanged e,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(pendingRadius: e.radiusMeters));
  }

  Future<void> _onRadiusApplied(
    MapRadiusApplied e,
    Emitter<MapState> emit,
  ) async {
    final radius =
        state.pendingRadius ?? state.radiusMeters ?? 2000; // default 2km
    emit(state.copyWith(radiusMeters: radius));

    if (state.userLat != null && state.userLon != null) {
      try {
        final items = await getNearby(
          lat: state.userLat!,
          lon: state.userLon!,
          radiusMeters: radius,
        );
        emit(state.copyWith(nearby: items, error: null));
      } catch (err) {
        emit(state.copyWith(error: err.toString()));
      }
    }
  }

  void _onRecenterRequested(MapRecenterRequested e, Emitter<MapState> emit) {
    emit(state.copyWith(recenterTick: state.recenterTick + 1));
  }

  Future<void> _onIncidentTapped(
    MapIncidentTapped e,
    Emitter<MapState> emit,
  ) async {
    try {
      final preview = await getPreview(e.incidentId);
      emit(state.copyWith(selected: preview, error: null));
    } catch (err) {
      emit(state.copyWith(error: err.toString()));
    }
  }

  @override
  Future<void> close() {
    _posSub?.cancel();
    return super.close();
  }
}

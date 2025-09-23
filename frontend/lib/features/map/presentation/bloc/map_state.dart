part of 'map_bloc.dart';

class MapState extends Equatable {
  final double? userLat;
  final double? userLon;
  final int? radiusMeters; // applied
  final int? pendingRadius; // UI selection not applied yet
  final List<NearbyIncident> nearby;
  final IncidentPreview? selected;
  final String? error;
  final int recenterTick; // bump to signal UI to recenter
  final DateTime? lastCameraToUser;

  const MapState({
    this.userLat,
    this.userLon,
    this.radiusMeters,
    this.pendingRadius,
    this.nearby = const [],
    this.selected,
    this.error,
    this.recenterTick = 0,
    this.lastCameraToUser,
  });

  MapState copyWith({
    double? userLat,
    double? userLon,
    int? radiusMeters,
    int? pendingRadius,
    List<NearbyIncident>? nearby,
    IncidentPreview? selected,
    String? error,
    int? recenterTick,
    DateTime? lastCameraToUser,
    bool clearSelected = false,
  }) {
    return MapState(
      userLat: userLat ?? this.userLat,
      userLon: userLon ?? this.userLon,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      pendingRadius: pendingRadius ?? this.pendingRadius,
      nearby: nearby ?? this.nearby,
      selected: clearSelected ? null : (selected ?? this.selected),
      error: error,
      recenterTick: recenterTick ?? this.recenterTick,
      lastCameraToUser: lastCameraToUser ?? this.lastCameraToUser,
    );
  }

  @override
  List<Object?> get props => [
    userLat,
    userLon,
    radiusMeters,
    pendingRadius,
    nearby,
    selected,
    error,
    recenterTick,
    lastCameraToUser,
  ];
}

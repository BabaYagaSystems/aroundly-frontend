// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

import '../../domain/entities/nearby_incident.dart';
import '../bloc/map_bloc.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  mp.MapboxMap? _map;
  mp.PointAnnotationManager? _pointManager;

  // Map annotation.id (String) -> incident.id (int)
  final Map<String, int> _annIdToIncidentId = {};

  static const _circleSourceId = 'user-radius-source';
  static const _circleLayerId = 'user-radius-layer';

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(MapStarted());
  }

  Future<void> _onMapCreated(mp.MapboxMap controller) async {
    _map = controller;

    // Enable location puck
    await _map?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    // Point annotations for incidents
    _pointManager = await _map!.annotations.createPointAnnotationManager();

    // Use deprecated click listener on SDK 35 (tapEvents isn't a Stream here)
    _pointManager!.addOnPointAnnotationClickListener(
      (ann) {
            final annId = ann.id;
            if (annId != null) {
              final incId = _annIdToIncidentId[annId];
              if (incId != null) {
                context.read<MapBloc>().add(MapIncidentTapped(incId));
              }
            }
            return true;
          }
          as mp.OnPointAnnotationClickListener,
    );

    await _ensureCircleLayer();
  }

  Future<void> _ensureCircleLayer() async {
    if (_map == null) return;

    // Remove existing (ignore if missing)
    try {
      await _map!.style.removeStyleLayer(_circleLayerId);
    } catch (_) {}
    try {
      await _map!.style.removeStyleSource(_circleSourceId);
    } catch (_) {}

    // Empty GeoJSON source (pass JSON string)
    const emptyFc = '{"type":"FeatureCollection","features":[]}';
    await _map!.style.addSource(
      mp.GeoJsonSource(id: _circleSourceId, data: emptyFc),
    );

    // Fill layer (ARGB ints)
    final fillLayer = mp.FillLayer(
      id: _circleLayerId,
      sourceId: _circleSourceId,
      fillColor: 0x3355A5FF,
      fillOutlineColor: 0x9955A5FF,
    );
    await _map!.style.addLayer(fillLayer);
  }

  void _updateCirclePolygon(double lat, double lon, int radiusMeters) async {
    if (_map == null) return;

    final coords = _circleCoordinates(lat, lon, radiusMeters);
    final geojson = jsonEncode({
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "Polygon",
            "coordinates": [coords],
          },
        },
      ],
    });

    await _map!.style.setStyleSourceProperty(_circleSourceId, "data", geojson);
  }

  List<List<double>> _circleCoordinates(
    double lat,
    double lon,
    int radiusMeters,
  ) {
    const steps = 64, earthRadius = 6371000;
    final cLat = lat * math.pi / 180.0,
        cLon = lon * math.pi / 180.0,
        dByR = radiusMeters / earthRadius;

    final out = <List<double>>[];
    for (var i = 0; i <= steps; i++) {
      final brng = 2 * math.pi * i / steps;
      final latRad = math.asin(
        math.sin(cLat) * math.cos(dByR) +
            math.cos(cLat) * math.sin(dByR) * math.cos(brng),
      );
      final lonRad =
          cLon +
          math.atan2(
            math.sin(brng) * math.sin(dByR) * math.cos(cLat),
            math.cos(dByR) - math.sin(cLat) * math.sin(latRad),
          );
      out.add([lonRad * 180 / math.pi, latRad * 180 / math.pi]);
    }
    return out; // closed ring (first=last) because i <= steps
  }

  Future<void> _renderIncidents(List<NearbyIncident> items) async {
    if (_pointManager == null) return;

    _annIdToIncidentId.clear();
    await _pointManager!.deleteAll();

    final options = items.map((e) {
      return mp.PointAnnotationOptions(
        geometry: mp.Point(coordinates: mp.Position(e.lon, e.lat)),
        // set custom icon via 'image' (Uint8List) if needed
      );
    }).toList();

    final created = await _pointManager!.createMulti(options);
    for (var i = 0; i < created.length && i < items.length; i++) {
      final annId = created[i]!.id;
      _annIdToIncidentId[annId] = items[i].id;
    }
  }

  void _recenterCamera(double lat, double lon) {
    _map?.flyTo(
      mp.CameraOptions(
        center: mp.Point(coordinates: mp.Position(lon, lat)),
        zoom: 14.5,
      ),
      mp.MapAnimationOptions(duration: 800),
    );
  }

  void _openRadiusSheet(BuildContext context, MapState state) {
    final bloc = context.read<MapBloc>();
    int current = state.pendingRadius ?? state.radiusMeters ?? 2000;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: StatefulBuilder(
            builder: (context, setModal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter radius',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    min: 0,
                    max: 3,
                    divisions: 3,
                    label: _radiusLabel(current),
                    value: _indexFromRadius(current).toDouble(),
                    onChanged: (v) {
                      final idx = v.round();
                      current = _radiusFromIndex(idx);
                      setModal(() {});
                      bloc.add(MapRadiusChanged(current));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _radiusLabel(current),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          bloc.add(MapRadiusApplied());
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String _radiusLabel(int meters) => '${(meters / 1000).toStringAsFixed(0)} km';
  int _radiusFromIndex(int i) => const [2000, 5000, 10000, 15000][i];
  int _indexFromRadius(int r) =>
      const {2000: 0, 5000: 1, 10000: 2, 15000: 3}[r] ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) async {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }

          if (_map != null) {
            if (state.userLat != null &&
                state.userLon != null &&
                state.radiusMeters != null) {
              _updateCirclePolygon(
                state.userLat!,
                state.userLon!,
                state.radiusMeters!,
              );
            }
            await _renderIncidents(state.nearby);
            if (state.recenterTick > 0 &&
                state.userLat != null &&
                state.userLon != null) {
              _recenterCamera(state.userLat!, state.userLon!);
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              mp.MapWidget(
                onMapCreated: _onMapCreated,
                styleUri: mp.MapboxStyles.DARK,
              ),

              // Top-left FAB (radius filter)
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FloatingActionButton.small(
                      heroTag: 'fab_filter',
                      onPressed: () => _openRadiusSheet(context, state),
                      child: const Icon(Icons.tune),
                    ),
                  ),
                ),
              ),

              // Bottom-right recenter
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      heroTag: 'fab_recenter',
                      onPressed: () =>
                          context.read<MapBloc>().add(MapRecenterRequested()),
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ),
              ),

              // Bottom preview (above nav bar)
              if (state.selected != null)
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                      ),
                      child: _IncidentPreviewCard(
                        title: state.selected!.title,
                        imageUri: state.selected!.imageUri,
                        onClose: () =>
                            context.read<MapBloc>().add(MapPreviewDismissed()),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _IncidentPreviewCard extends StatelessWidget {
  final String title;
  final String? imageUri;
  final VoidCallback onClose;

  const _IncidentPreviewCard({
    required this.title,
    required this.imageUri,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            if (imageUri != null)
              SizedBox(
                width: 96,
                height: 96,
                child: _ImageFromUri(imageUri: imageUri!),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap marker for more details',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}

class _ImageFromUri extends StatelessWidget {
  final String imageUri;
  const _ImageFromUri({required this.imageUri});

  @override
  Widget build(BuildContext context) {
    if (imageUri.startsWith('data:image')) {
      final base64Part = imageUri.split(',').last;
      return Image.memory(
        const Base64Decoder().convert(base64Part),
        fit: BoxFit.cover,
      );
    }
    return Image.network(imageUri, fit: BoxFit.cover);
  }
}

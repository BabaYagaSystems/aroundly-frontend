import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  mp.MapboxMap? mapboxMapController;
  StreamSubscription? userPositionStream;

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  void _onMapCreated(mp.MapboxMap controller) {
    setState(() {
      mapboxMapController = controller;
    });

    mapboxMapController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are disabled!");
    }

    permission = await gl.Geolocator.checkPermission();

    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error("Location services are denied!");
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error(
        "Location permissions are permanently denied, we cannot request permission!",
      );
    }

    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen((gl.Position? position) {
          if (position != null && mapboxMapController != null) {
            mapboxMapController?.setCamera(
              mp.CameraOptions(
                zoom: 15,
                center: mp.Point(
                  coordinates: mp.Position(
                    position.longitude,
                    position.latitude,
                  ),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mp.MapWidget(
        onMapCreated: _onMapCreated,
        styleUri: mp.MapboxStyles.DARK,
      ),
    );
  }
}

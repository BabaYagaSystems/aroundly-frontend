import '../../domain/entities/nearby_incident.dart';

class NearbyIncidentModel {
  final int id;
  final String title;
  final double lat;
  final double lon;
  final String? imageUri;

  const NearbyIncidentModel({
    required this.id,
    required this.title,
    required this.lat,
    required this.lon,
    this.imageUri,
  });

  factory NearbyIncidentModel.fromJson(Map<String, dynamic> json) {
    // Assumptions: backend returns id, lat, lon. If not, adapt mapping.
    final media =
        (json['media'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final firstImage = media.firstWhere(
      (m) => (m['kind'] == 'IMAGE'),
      orElse: () => const {},
    );
    return NearbyIncidentModel(
      id: (json['id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0,
      imageUri: (firstImage['uri'] as String?),
    );
  }

  NearbyIncident toDomain() => NearbyIncident(
    id: id,
    title: title,
    lat: lat,
    lon: lon,
    imageUri: imageUri,
  );
}

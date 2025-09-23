import '../../domain/entities/incident.dart';
import 'incident_media_model.dart';

class IncidentRequestModel {
  final String title;
  final String description;
  final double lat;
  final double lon;
  final List<IncidentMediaModel> media;

  const IncidentRequestModel({
    required this.title,
    required this.description,
    required this.lat,
    required this.lon,
    this.media = const [],
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'lat': lat,
    'lon': lon,
    'media': media.map((m) => m.toJson()).toList(),
  };

  static IncidentRequestModel fromDomain(Incident incident) =>
      IncidentRequestModel(
        title: incident.title,
        description: incident.description,
        lat: incident.lat,
        lon: incident.lon,
        media: incident.media
            .map(
              (e) => IncidentMediaModel(
                kind: e.kind,
                contentType: e.contentType,
                uri: e.uri,
              ),
            )
            .toList(),
      );
}

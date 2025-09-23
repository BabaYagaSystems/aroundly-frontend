import 'incident_media.dart';

class Incident {
  final String title;
  final String description;
  final double lat;
  final double lon;
  final List<IncidentMedia> media;

  const Incident({
    required this.title,
    required this.description,
    required this.lat,
    required this.lon,
    this.media = const [],
  });
}

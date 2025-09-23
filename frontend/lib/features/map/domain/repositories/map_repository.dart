import '../entities/incident_preview.dart';
import '../entities/nearby_incident.dart';

abstract class MapRepository {
  Future<List<NearbyIncident>> getNearby({
    required double lat,
    required double lon,
    required int radiusMeters,
  });
  Future<IncidentPreview> getPreview(int id);
}

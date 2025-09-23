import '../entities/nearby_incident.dart';
import '../repositories/map_repository.dart';

class GetNearbyIncidentsUseCase {
  final MapRepository repo;
  GetNearbyIncidentsUseCase(this.repo);
  Future<List<NearbyIncident>> call({
    required double lat,
    required double lon,
    required int radiusMeters,
  }) => repo.getNearby(lat: lat, lon: lon, radiusMeters: radiusMeters);
}

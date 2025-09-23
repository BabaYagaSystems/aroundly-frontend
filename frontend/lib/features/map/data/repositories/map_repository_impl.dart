import '../../domain/entities/incident_preview.dart';
import '../../domain/entities/nearby_incident.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/map_remote_data_source.dart';

class MapRepositoryImpl implements MapRepository {
  final IMapRemoteDataSource remote;
  MapRepositoryImpl(this.remote);

  @override
  Future<List<NearbyIncident>> getNearby({
    required double lat,
    required double lon,
    required int radiusMeters,
  }) async {
    final items = await remote.getNearby(
      lat: lat,
      lon: lon,
      radiusMeters: radiusMeters,
    );
    return items.map((e) => e.toDomain()).toList();
  }

  @override
  Future<IncidentPreview> getPreview(int id) async {
    final model = await remote.getPreview(id);
    return model.toDomain();
  }
}

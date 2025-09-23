import '../../domain/entities/incident.dart';
import '../../domain/entities/incident_created_response.dart';
import '../../domain/repositories/incident_repository.dart';
import '../datasources/incident_remote_data_source.dart';
import '../models/incident_request_model.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final IIncidentRemoteDataSource remote;

  IncidentRepositoryImpl(this.remote);

  @override
  Future<IncidentCreatedResponse> createIncident(Incident incident) async {
    final req = IncidentRequestModel.fromDomain(incident);
    final res = await remote.createIncident(req);
    return res.toDomain();
  }
}

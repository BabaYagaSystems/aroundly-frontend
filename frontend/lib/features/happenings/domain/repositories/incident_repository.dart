import '../entities/incident.dart';
import '../entities/incident_created_response.dart';

abstract class IncidentRepository {
  Future<IncidentCreatedResponse> createIncident(Incident incident);
}

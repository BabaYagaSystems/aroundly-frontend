import '../entities/incident.dart';
import '../entities/incident_created_response.dart';
import '../repositories/incident_repository.dart';

class CreateIncidentUseCase {
  final IncidentRepository repository;
  CreateIncidentUseCase(this.repository);

  Future<IncidentCreatedResponse> call(Incident incident) {
    return repository.createIncident(incident);
  }
}

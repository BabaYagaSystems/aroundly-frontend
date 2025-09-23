import '../entities/incident_preview.dart';
import '../repositories/map_repository.dart';

class GetIncidentPreviewUseCase {
  final MapRepository repo;
  GetIncidentPreviewUseCase(this.repo);
  Future<IncidentPreview> call(int id) => repo.getPreview(id);
}

import 'package:frontend/features/happenings/domain/entities/location_entity.dart';
import 'package:frontend/features/happenings/domain/entities/media_entity.dart';
import 'package:frontend/features/happenings/domain/entities/metadata_entity.dart';

class IncidentEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String createdBy;

  // Relations
  final LocationEntity location;
  final List<MediaEntity> media;
  final MetadataEntity metadata;

  const IncidentEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.location,
    required this.media,
    required this.metadata,
  });
}

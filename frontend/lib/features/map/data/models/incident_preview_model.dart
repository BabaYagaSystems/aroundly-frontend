import '../../domain/entities/incident_preview.dart';

class IncidentPreviewModel {
  final int id;
  final String title;
  final String? imageUri;

  const IncidentPreviewModel({
    required this.id,
    required this.title,
    this.imageUri,
  });

  factory IncidentPreviewModel.fromJson(Map<String, dynamic> json) {
    final media =
        (json['media'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final firstImage = media.firstWhere(
      (m) => (m['kind'] == 'IMAGE'),
      orElse: () => const {},
    );
    return IncidentPreviewModel(
      id: (json['id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      imageUri: (firstImage['uri'] as String?),
    );
  }

  IncidentPreview toDomain() =>
      IncidentPreview(id: id, title: title, imageUri: imageUri);
}

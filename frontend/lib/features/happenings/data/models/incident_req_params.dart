import 'package:frontend/features/happenings/data/models/metadata_model.dart';

class IncidentReqParams {
  final String title;
  final String description;
  final Metadata metadata;

  IncidentReqParams({
    required this.title,
    required this.description,
    required this.metadata,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
      "description": description,
      "metadata": metadata,
    };
  }
}

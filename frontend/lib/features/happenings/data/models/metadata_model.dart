import 'package:frontend/features/happenings/data/models/location_model.dart';
import 'package:frontend/features/happenings/data/models/media_model.dart';

class Metadata {
  final List<Media> media;
  final Location location;

  Metadata({required this.media, required this.location});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"media": media, "location": location};
  }
}

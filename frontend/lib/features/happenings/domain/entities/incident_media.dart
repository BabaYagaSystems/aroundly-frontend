class IncidentMedia {
  final String kind; // e.g. "IMAGE"
  final String contentType; // e.g. "image/jpeg"
  final String uri; // e.g. base64 data URL or remote URL

  const IncidentMedia({
    required this.kind,
    required this.contentType,
    required this.uri,
  });
}

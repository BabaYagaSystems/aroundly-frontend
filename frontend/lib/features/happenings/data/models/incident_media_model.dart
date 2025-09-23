class IncidentMediaModel {
  final String kind; // IMAGE
  final String contentType; // image/jpeg
  final String uri; // data URL or URL

  const IncidentMediaModel({
    required this.kind,
    required this.contentType,
    required this.uri,
  });

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'contentType': contentType,
    'uri': uri,
  };
}

class NearbyIncident {
  final int id; // assuming backend returns an id; if not, make nullable
  final String title;
  final double lat;
  final double lon;
  final String? imageUri; // optional thumbnail/base64/URL

  const NearbyIncident({
    required this.id,
    required this.title,
    required this.lat,
    required this.lon,
    this.imageUri,
  });
}

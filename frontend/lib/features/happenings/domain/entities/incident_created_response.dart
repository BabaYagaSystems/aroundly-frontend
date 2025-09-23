class IncidentCreatedResponse {
  final String title;
  final String description;
  final String actorUsername;
  final int confirm;
  final int deny;
  final int consecutiveDenies;
  final int like;
  final int dislike;
  final double lat;
  final double lon;
  final String address;

  const IncidentCreatedResponse({
    required this.title,
    required this.description,
    required this.actorUsername,
    required this.confirm,
    required this.deny,
    required this.consecutiveDenies,
    required this.like,
    required this.dislike,
    required this.lat,
    required this.lon,
    required this.address,
  });
}

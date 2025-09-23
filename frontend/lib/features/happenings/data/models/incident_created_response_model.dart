import '../../domain/entities/incident_created_response.dart';

class IncidentCreatedResponseModel {
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

  const IncidentCreatedResponseModel({
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

  factory IncidentCreatedResponseModel.fromJson(Map<String, dynamic> json) =>
      IncidentCreatedResponseModel(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        actorUsername: json['actorUsername'] ?? '',
        confirm: (json['confirm'] ?? 0) as int,
        deny: (json['deny'] ?? 0) as int,
        consecutiveDenies: (json['consecutiveDenies'] ?? 0) as int,
        like: (json['like'] ?? 0) as int,
        dislike: (json['dislike'] ?? 0) as int,
        lat: (json['lat'] as num?)?.toDouble() ?? 0,
        lon: (json['lon'] as num?)?.toDouble() ?? 0,
        address: json['address'] ?? '',
      );

  IncidentCreatedResponse toDomain() => IncidentCreatedResponse(
    title: title,
    description: description,
    actorUsername: actorUsername,
    confirm: confirm,
    deny: deny,
    consecutiveDenies: consecutiveDenies,
    like: like,
    dislike: dislike,
    lat: lat,
    lon: lon,
    address: address,
  );
}

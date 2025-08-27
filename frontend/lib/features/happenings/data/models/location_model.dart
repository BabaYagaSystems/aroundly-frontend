class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
    };
  }
}

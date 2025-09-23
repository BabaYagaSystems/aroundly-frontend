class ApiConstants {
  static const String baseUrl = "https://aroundly-production.up.railway.app/";

  // Endpoints
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String createIncident = "api/v1/incidents";
  static const String incidentsNearbyPath = "api/v1/incidents/nearby";
  static String incidentPreviewPath(String id) {
    return "api/v1/incidents/$id/preview";
  }
}

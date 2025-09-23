import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_constants.dart';

import '../../../../core/network/dio_client.dart';
import '../models/incident_preview_model.dart';
import '../models/nearby_incident_model.dart';

abstract class IMapRemoteDataSource {
  Future<List<NearbyIncidentModel>> getNearby({
    required double lat,
    required double lon,
    required int radiusMeters,
  });
  Future<IncidentPreviewModel> getPreview(int id);
}

class MapRemoteDataSource implements IMapRemoteDataSource {
  final DioClient _client;
  // e.g. /api/v1/incidents

  MapRemoteDataSource(this._client);

  @override
  Future<List<NearbyIncidentModel>> getNearby({
    required double lat,
    required double lon,
    required int radiusMeters,
  }) async {
    final resp = await _client.get(
      ApiConstants.incidentsNearbyPath,
      queryParameters: {'lat': lat, 'lon': lon, 'radius': radiusMeters},
    );
    if (resp.statusCode == 200) {
      final list = (resp.data as List).cast<Map<String, dynamic>>();
      return list.map((e) => NearbyIncidentModel.fromJson(e)).toList();
    }
    throw DioException(
      requestOptions: resp.requestOptions,
      response: resp,
      type: DioExceptionType.badResponse,
    );
  }

  @override
  Future<IncidentPreviewModel> getPreview(int id) async {
    final resp = await _client.get('api/v1/incidents/$id/preview');
    if (resp.statusCode == 200) {
      return IncidentPreviewModel.fromJson(
        (resp.data as Map<String, dynamic>)..['id'] = id,
      );
    }
    throw DioException(
      requestOptions: resp.requestOptions,
      response: resp,
      type: DioExceptionType.badResponse,
    );
  }
}

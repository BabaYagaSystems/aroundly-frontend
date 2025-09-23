import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_constants.dart';

import '../../../../core/network/dio_client.dart';
import '../models/incident_created_response_model.dart';
import '../models/incident_request_model.dart';

abstract class IIncidentRemoteDataSource {
  Future<IncidentCreatedResponseModel> createIncident(
    IncidentRequestModel model,
  );
}

class IncidentRemoteDataSource implements IIncidentRemoteDataSource {
  final DioClient _client;

  IncidentRemoteDataSource(this._client);

  @override
  Future<IncidentCreatedResponseModel> createIncident(
    IncidentRequestModel model,
  ) async {
    final response = await _client.post(
      ApiConstants.createIncident,
      data: model.toJson(),
      // options: Options(
      //   headers: {'Content-Type': 'application/json; charset=UTF-8'},
      // ),
    );

    if (response.statusCode == 201) {
      return IncidentCreatedResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    }

    // Map 400/409 to DioException for the BLoC to handle nicely
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
      error: 'Failed with status ${response.statusCode}',
    );
  }

  // --- Alternative: multipart upload if backend requires a file payload ---
  // Future<IncidentCreatedResponseModel> createIncidentMultipart({
  // required String title,
  // required String description,
  // required double lat,
  // required double lon,
  // required XFile image,
  // }) async {
  // final formData = FormData.fromMap({
  // 'title': title,
  // 'description': description,
  // 'lat': lat,
  // 'lon': lon,
  // 'file': await MultipartFile.fromFile(image.path, filename: 'incident.jpg', contentType: MediaType('image','jpeg')),
  // });
  // final resp = await client.post(endpoint, data: formData, options: Options(contentType: 'multipart/form-data'));
  // if (resp.statusCode == 201) {
  // return IncidentCreatedResponseModel.fromJson(resp.data as Map<String, dynamic>);
  // }
  // throw DioException(requestOptions: resp.requestOptions, response: resp, type: DioExceptionType.badResponse);
  // }
}

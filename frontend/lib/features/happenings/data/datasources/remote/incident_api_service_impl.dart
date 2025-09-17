import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/features/happenings/data/datasources/remote/incident_api_service.dart';
import 'package:frontend/features/happenings/data/models/incident_req_params.dart';
import 'package:frontend/features/happenings/domain/entities/incident_entity.dart';

class IncidentApiServiceImpl implements IncidentApiService {
  @override
  Future<Either<Errors, IncidentEntity>> createIncident(IncidentReqParams req) {
    // TODO: implement createIncident
    throw UnimplementedError();
  }
}

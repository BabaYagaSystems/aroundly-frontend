import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/features/happenings/data/models/incident_req_params.dart';
import 'package:frontend/features/happenings/domain/entities/incident_entity.dart';

abstract class IncidentRepository {
  Future<Either<Errors, IncidentEntity>> createIncident(
    IncidentReqParams params,
  );
}

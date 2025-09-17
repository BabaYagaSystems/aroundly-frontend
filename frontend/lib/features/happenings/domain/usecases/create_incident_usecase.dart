import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/features/happenings/data/models/incident_req_params.dart';
import 'package:frontend/features/happenings/domain/entities/incident_entity.dart';
import 'package:frontend/features/happenings/domain/repositories/incident_repository.dart';
import 'package:frontend/service_locator.dart';

class CreateIncidentUsecase
    implements Usecase<IncidentEntity, IncidentReqParams> {
  @override
  Future<Either<Errors, IncidentEntity>> call({
    IncidentReqParams? param,
  }) async {
    return sl<IncidentRepository>().createIncident(param!);
  }
}

import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';

abstract class Usecase<Type, Param> {
  Future<Either<Errors, Type>> call({Param param});
}

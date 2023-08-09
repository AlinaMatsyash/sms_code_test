import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/fate.dart';

abstract class FateRepository {
  Future<Either<Failure, Fate>> geFate();
}

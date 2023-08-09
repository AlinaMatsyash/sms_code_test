import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/fate.dart';
import '../repositories/fate_repository.dart';

class GetFate implements UseCase<Fate, NoParams> {
  final FateRepository repository;

  GetFate(this.repository);

  @override
  Future<Either<Failure, Fate>> call(NoParams params) async {
    return await repository.geFate();
  }
}

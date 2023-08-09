import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/fate.dart';
import '../../domain/repositories/fate_repository.dart';
import '../datasources/fate.dart';

class FateRepositoryImpl implements FateRepository {
  final FateDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FateRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Fate>> geFate() async {
    if (await networkInfo.isConnected) {
      try {
        final fate = await remoteDataSource.getFate();
        return Right(fate);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }
}

import 'package:chat_test/core/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/get_fate/data/datasources/fate.dart';
import 'features/get_fate/data/repositories/fate.dart';
import 'features/get_fate/domain/repositories/fate_repository.dart';
import 'features/get_fate/domain/usecases/get_fate.dart';
import 'features/get_fate/presentation/bloc/fate_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => FateBloc(
      fate: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetFate(sl()));

  // Repository
  sl.registerLazySingleton<FateRepository>(
    () => FateRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FateDataSource>(
    () => FateDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

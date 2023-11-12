import 'package:get_it/get_it.dart';
import 'package:stopwatch/features/auth/domain/login_service.dart';

import '../../features/stopwatch/data/repository/stopwatch_repository.dart';
import '../../features/stopwatch/domain/stopwatch_data_service.dart';

final getIt = GetIt.I;

void setupLocator() {
  getIt.registerLazySingleton(() => LoginService());
  getIt.registerLazySingleton(() => StopWatchStorageService());
  getIt.registerFactory(() => StopwatchRepository());
}

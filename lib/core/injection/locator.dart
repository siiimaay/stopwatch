import 'package:get_it/get_it.dart';
import 'package:stopwatch/features/auth/domain/login_service.dart';

final getIt = GetIt.I;

void setupLocator() {
  getIt.registerLazySingleton(() => LoginService());
}

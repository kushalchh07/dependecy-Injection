import 'package:dependency_injection/services/appservice.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
// void setupLocator() {
//   locator.registerSingleton<AppService>(
//     AppService(),
//   );
// }

void setupLocator() {
  locator.registerLazySingleton<AppService>(
    () => AppService(),
  );
}
// void setupLocator() {
//   locator.registerFactory<AppService>(
//     () => AppService(),
//   );
// }


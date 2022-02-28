import 'package:get_it/get_it.dart';
import 'package:happy_shouket/src/providers/analytics.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AnalyticsService());
}

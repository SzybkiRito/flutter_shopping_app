import 'package:get_it/get_it.dart';
import 'package:shopping_app/api/api_service.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/services/service_database.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  // Register services
  serviceLocator.registerSingleton<ApiService>(ApiService());
  serviceLocator.registerSingleton<Authentication>(Authentication());
  serviceLocator.registerSingleton<DatabaseService>(DatabaseService());
}

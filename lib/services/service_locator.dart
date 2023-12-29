import 'package:get_it/get_it.dart';
import 'package:shopping_app/api/api_service.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/services/service_database.dart';
import 'package:shopping_app/services/service_product_sqflite.dart';
import 'package:shopping_app/services/service_shopping_cart_sqflite.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  // Register services
  serviceLocator.registerSingleton<ApiService>(ApiService());
  serviceLocator.registerSingleton<Authentication>(Authentication());
  serviceLocator.registerSingleton<DatabaseService>(DatabaseService());

  // Register sqflite services
  serviceLocator.registerSingleton<ProductSqflite>(ProductSqflite());
  serviceLocator.registerSingleton<ShoppingCartSqflite>(ShoppingCartSqflite());
}

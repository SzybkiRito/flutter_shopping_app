import 'package:shopping_app/api/api_service.dart';
import 'package:shopping_app/api/models/product.dart';
import 'package:shopping_app/services/service_locator.dart';

final ApiService apiService = serviceLocator<ApiService>();
Future<List<Product>> fetchProducts() async {
  final List<dynamic> productsJson = await apiService.get('/products');
  return productsJson.map((productJson) => Product.fromJson(productJson)).toList();
}

Future<List<Product>> fetchCheapestProducts() async {
  final List<dynamic> productsJson = await apiService.get('/products?sort=desc');
  return productsJson.map((productJson) => Product.fromJson(productJson)).toList();
}

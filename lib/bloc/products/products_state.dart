import 'package:shopping_app/api/models/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> popularProducts;
  final List<Product> cheapestProducts;

  ProductsLoaded({required this.popularProducts, required this.cheapestProducts});
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/api/connection/fetch_products.dart';
import 'package:shopping_app/bloc/products/products_events.dart';
import 'package:shopping_app/bloc/products/products_state.dart';
import 'package:shopping_app/constants/models/product.dart';

class ProductsBloc extends Bloc<ProductsEvents, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsFetchEvent>(_onFetchProducts);
    // on<FetchCheapestProductsEvent>(_onFetchCheapestProducts);
  }

  void _onFetchProducts(ProductsFetchEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final List<Product> popularProducts = await fetchProducts();
    final List<Product> cheapestProducts = await fetchCheapestProducts();

    if (popularProducts.isEmpty || cheapestProducts.isEmpty) {
      emit(ProductsError(message: 'No products found'));
      return;
    }

    emit(ProductsLoaded(popularProducts: popularProducts, cheapestProducts: cheapestProducts));
  }
}

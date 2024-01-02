import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/constants/models/shopping_cart.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:shopping_app/services/service_product_sqflite.dart';
import 'package:shopping_app/services/service_shopping_cart_sqflite.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CheckoutFetchEvent>(_onFetch);
    on<CheckoutRemoveEvent>(_onRemove);
  }

  void _onFetch(CheckoutFetchEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final ShoppingCartSqflite shoppingCartSqflite = serviceLocator<ShoppingCartSqflite>();
    final List<ShoppingCart?> shoppingCarts = await shoppingCartSqflite.getShoppingCartByUserId(event.userId);
    final products = await _parseProductsFromCarts(shoppingCarts);

    emit(
      CheckoutLoaded(
        products: products,
        shoppingCarts: shoppingCarts,
      ),
    );
  }

  Future<List<Product>> _parseProductsFromCarts(List<ShoppingCart?> shoppingCarts) async {
    final ProductSqflite productSqflite = serviceLocator<ProductSqflite>();
    List<Product> products = [];
    for (final ShoppingCart? shoppingCart in shoppingCarts) {
      if (shoppingCart == null) {
        continue;
      }
      final Product? product = await productSqflite.getProductById(shoppingCart.productId);
      if (product != null) {
        products.add(product);
      }
    }

    return products;
  }

  String calculateTotalPrice(List<Product> products) {
    double totalPrice = products.fold(0, (previousValue, element) => previousValue + element.price);
    return totalPrice.toStringAsFixed(2);
  }

  void _onRemove(CheckoutRemoveEvent event, Emitter<CheckoutState> emit) async {
    final ShoppingCartSqflite shoppingCartSqflite = serviceLocator<ShoppingCartSqflite>();
    if (event.cart == null) {
      emit(CheckoutError(message: 'Something went wrong!'));
      return;
    }

    bool removed = await shoppingCartSqflite.removeShoppingCart(event.cart!);
    if (!removed) {
      emit(CheckoutError(message: 'Could not remove the item.'));
      return;
    }

    if (state is CheckoutLoaded) {
      final currentState = state as CheckoutLoaded;
      final List<ShoppingCart?> updatedShoppingCarts = List<ShoppingCart?>.from(currentState.shoppingCarts)
        ..removeWhere((cart) => cart?.id == event.cart!.id);
      final List<Product> updatedProducts = List<Product>.from(currentState.products)..removeAt(event.index);

      emit(CheckoutLoaded(products: updatedProducts, shoppingCarts: updatedShoppingCarts));
    }
  }
}

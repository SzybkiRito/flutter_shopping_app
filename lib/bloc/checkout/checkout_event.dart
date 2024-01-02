part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class CheckoutFetchEvent extends CheckoutEvent {
  final String userId;

  CheckoutFetchEvent(this.userId);
}

final class CheckoutRemoveEvent extends CheckoutEvent {
  final int index;
  final ShoppingCart? cart;

  CheckoutRemoveEvent(this.cart, this.index);
}

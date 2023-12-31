part of 'favorties_bloc.dart';

@immutable
sealed class FavortiesEvent {}

final class FavoritesFetchEvent extends FavortiesEvent {}

final class FavoritesRemoveEvent extends FavortiesEvent {
  final Product productId;

  FavoritesRemoveEvent(this.productId);
}

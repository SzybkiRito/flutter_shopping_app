part of 'favorties_bloc.dart';

@immutable
sealed class FavortiesState {}

final class FavortiesInitial extends FavortiesState {}

final class FavortiesLoading extends FavortiesState {}

final class FavortiesLoaded extends FavortiesState {
  final List<Product> favoriteProducts;

  FavortiesLoaded({required this.favoriteProducts});
}

final class FavortiesError extends FavortiesState {
  final String message;

  FavortiesError({required this.message});
}

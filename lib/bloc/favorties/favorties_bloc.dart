import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/services/favorites_sqflite.dart';
import 'package:shopping_app/services/service_locator.dart';

part 'favorties_event.dart';
part 'favorties_state.dart';

class FavortiesBloc extends Bloc<FavortiesEvent, FavortiesState> {
  FavortiesBloc() : super(FavortiesInitial()) {
    on<FavortiesFetchEvent>(_onFetchFavorties);
  }

  void _onFetchFavorties(FavortiesFetchEvent event, Emitter<FavortiesState> emit) async {
    emit(FavortiesLoading());
    final favoritesSqflite = serviceLocator<FavoritesSqflite>();
    final List<Product> favoriteProducts = await favoritesSqflite.getFavoriteProductsByUserId();

    if (favoriteProducts.isEmpty) {
      emit(FavortiesError(message: 'No products found'));
      return;
    }

    emit(FavortiesLoaded(favoriteProducts: favoriteProducts));
  }
}

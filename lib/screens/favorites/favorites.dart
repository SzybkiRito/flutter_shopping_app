import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/favorties/favorties_bloc.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/widgets/product/horizontal_product_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Product> items = [];

  @override
  void initState() {
    super.initState();
    context.read<FavortiesBloc>().add(FavortiesFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SphereShopColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<FavortiesBloc, FavortiesState>(
          builder: (context, state) {
            if (state is FavortiesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavortiesError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is FavortiesLoaded) {
              items = state.favoriteProducts;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Dismissible(
                      key: ValueKey<int>(items[index].id),
                      child: HorizontalProductCard(
                        product: items[index],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}

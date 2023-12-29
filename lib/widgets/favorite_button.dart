import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/services/favorites_sqflite.dart';
import 'package:shopping_app/services/service_locator.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  const FavoriteButton({super.key, required this.product});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoritesSqflite favortiesSqflite = serviceLocator<FavoritesSqflite>();
  bool isProductMarkedAsFavorite = false;

  @override
  void initState() {
    super.initState();
    _isProductFavorite();
  }

  Future<void> _isProductFavorite() async {
    bool isFavorite = await favortiesSqflite.isProductFavorite(widget.product);
    setState(() {
      isProductMarkedAsFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    bool isFavorite = await favortiesSqflite.isProductFavorite(widget.product);
    if (isFavorite) {
      await favortiesSqflite.deleteFavoriteProduct(widget.product);
      setState(() {
        isProductMarkedAsFavorite = false;
      });
    } else {
      await favortiesSqflite.insertFavoriteProduct(widget.product);
      setState(() {
        isProductMarkedAsFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavoriteStatus,
      icon: isProductMarkedAsFavorite
          ? Icon(Icons.favorite, color: SphereShopColors.white)
          : Icon(Icons.favorite_border, color: SphereShopColors.white),
    );
  }
}

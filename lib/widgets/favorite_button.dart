import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:shopping_app/services/service_product_sqflite.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  const FavoriteButton({super.key, required this.product});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final ProductSqflite productSqflite = serviceLocator<ProductSqflite>();
  bool isProductMarkedAsFavorite = false;

  Future<Product> _updateOrInsertProduct() async {
    final Product? existingProduct = await productSqflite.getProduct(widget.product.id);
    Product updatedProduct = _createUpdatedProduct(existingProduct);
    if (existingProduct != null) {
      await productSqflite.updateProduct(updatedProduct);
    } else {
      await productSqflite.insertProduct(updatedProduct);
    }

    return updatedProduct;
  }

  Future<void> _toggleFavoriteStatus() async {
    Product updatedProduct = await _updateOrInsertProduct();
    setState(() {
      isProductMarkedAsFavorite = updatedProduct.isFavorite;
    });
  }

  Product _createUpdatedProduct(Product? existingProduct) {
    bool newFavoriteStatus = existingProduct != null ? !existingProduct.isFavorite : true;

    return Product(
      id: widget.product.id,
      title: widget.product.title,
      price: widget.product.price,
      description: widget.product.description,
      image: widget.product.image,
      category: widget.product.category,
      rating: widget.product.rating,
      isFavorite: newFavoriteStatus,
    );
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

import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/constants/models/shopping_cart.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:shopping_app/services/service_product_sqflite.dart';
import 'package:shopping_app/services/service_shopping_cart_sqflite.dart';
import 'package:shopping_app/widgets/elevated_button.dart';
import 'package:shopping_app/widgets/favorite_button.dart';

class ProductPreview extends StatefulWidget {
  final Product product;
  const ProductPreview({
    super.key,
    required this.product,
  });

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  final GlobalKey _containerKey = GlobalKey();
  final ProductSqflite productSqflite = serviceLocator<ProductSqflite>();
  final ShoppingCartSqflite shoppingCartSqflite = serviceLocator<ShoppingCartSqflite>();
  bool isProductMarkedAsFavorite = false;
  double _descriptionHeight = 0.0;

  void _notifyUserThatProductIsAddedToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Product added to cart!',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: SphereShopColors.white,
              ),
        ),
        backgroundColor: SphereShopColors.primaryColorDark,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _addToCart() async {
    Product? isProductExistInDatabase = await productSqflite.getProduct(widget.product.id);
    if (isProductExistInDatabase == null) {
      await productSqflite.insertProduct(widget.product);
    }
    bool isProductAddedSuccesfully = await shoppingCartSqflite.insertShoppingCart(
      ShoppingCart(
        id: 1,
        userId: 1,
        productId: widget.product.id,
        quantity: 1,
      ),
    );
    if (isProductAddedSuccesfully) _notifyUserThatProductIsAddedToCart();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureDescription());
  }

  void _measureDescription() {
    final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      _descriptionHeight = renderBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SphereShopColors.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 600 + _descriptionHeight,
                    margin: const EdgeInsets.only(top: 150),
                    decoration: BoxDecoration(
                      color: SphereShopColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        15.0,
                        250.0,
                        15.0,
                        0.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 24,
                                ),
                          ),
                          Text(
                            widget.product.description,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: SphereShopColors.secondaryColorDark,
                                ),
                          ),
                          Container(
                            key: _containerKey,
                            margin: const EdgeInsets.only(top: 20.0),
                            decoration: BoxDecoration(
                              color: SphereShopColors.secondaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'IN-STOCK',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Icon(
                                          Icons.check_circle_outline,
                                          size: 20.0,
                                          color: SphereShopColors.secondaryColorDark,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'Pick up in store available!',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Text(
                                    widget.product.description,
                                    style: TextStyle(color: SphereShopColors.secondaryColorDark),
                                  ),
                                  Row(
                                    children: [
                                      Text('Rating: ', style: Theme.of(context).textTheme.titleMedium),
                                      Text(
                                        '${widget.product.rating.rate}',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                            color: widget.product.rating.rate <= 2.0
                                                ? SphereShopColors.red
                                                : SphereShopColors.green),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Rating count: ',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        '${widget.product.rating.count}',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              color: SphereShopColors.secondaryColorDark,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Category: ', style: Theme.of(context).textTheme.titleMedium),
                                      Text(
                                        widget.product.category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: SphereShopColors.secondaryColorDark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          widget.product.image,
                          height: 350,
                          width: 320,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: SphereShopColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PRICE',
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      color: SphereShopColors.white,
                                    ),
                              ),
                              Text(
                                '\$${widget.product.price}',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: SphereShopColors.white,
                                    ),
                              ),
                            ],
                          ),
                          SphereShopElevatedButton(
                            onPressed: _addToCart,
                            backgroundColor: SphereShopColors.primaryColorDark,
                            child: Text(
                              'ADD TO CART',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: SphereShopColors.white, fontSize: 16.0),
                            ),
                          ),
                          FavoriteButton(product: widget.product),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

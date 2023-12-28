import 'package:flutter/material.dart';
import 'package:shopping_app/api/models/product.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/widgets/elevated_button.dart';

class ProductPreview extends StatefulWidget {
  final Product product;
  const ProductPreview({
    super.key,
    required this.product,
  });

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  final double _collapsedHeight = 150.0;
  final double _expandedHeight = 350.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _heightAnimation = Tween<double>(begin: _collapsedHeight, end: _expandedHeight).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  bool get _isExpanded => _heightAnimation.value == _expandedHeight;

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
                    height: _heightAnimation.value + 450.0,
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
                            height: _heightAnimation.value,
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
                                  if (_isExpanded)
                                    Text(
                                      widget.product.description,
                                      style: TextStyle(color: SphereShopColors.secondaryColorDark),
                                    ),
                                  if (_isExpanded)
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
                                  if (_isExpanded)
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
                                  if (_isExpanded)
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
                                  if (_isExpanded) const Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextButton(
                                        onPressed: _toggleContainer,
                                        child: Column(
                                          children: [
                                            Text(
                                              _isExpanded ? 'READ LESS' : 'READ MORE',
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    color: SphereShopColors.primaryColor,
                                                  ),
                                            ),
                                            _isExpanded
                                                ? Icon(Icons.keyboard_arrow_up, color: SphereShopColors.primaryColor)
                                                : Icon(Icons.keyboard_arrow_down, color: SphereShopColors.primaryColor),
                                          ],
                                        ),
                                      ),
                                    ),
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
            Align(
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
                        onPressed: () {},
                        backgroundColor: SphereShopColors.primaryColorDark,
                        child: Text(
                          'ADD TO CART',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: SphereShopColors.white, fontSize: 16.0),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border, color: SphereShopColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

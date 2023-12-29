import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/constants/models/product.dart';

class HorizontalProductCard extends StatelessWidget {
  final Product product;
  const HorizontalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: SphereShopColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: 106,
                  height: 106,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$${product.price}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: SphereShopColors.secondaryColorDark,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

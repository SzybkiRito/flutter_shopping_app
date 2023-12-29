import 'package:flutter/material.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/widgets/product/product_image_shimmer.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const double defaultGapSize = 8.0;
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: defaultGapSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 240,
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const ProductImageShimmer();
              },
            ),
          ),
          const SizedBox(height: defaultGapSize),
          Text(
            product.title,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: defaultGapSize),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

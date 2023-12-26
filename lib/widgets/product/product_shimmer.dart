import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/widgets/product/product_image_shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductImageShimmer(),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: SphereShopColors.baseShimmerColor,
            highlightColor: SphereShopColors.baseShimmerHighlightColor,
            child: Container(
              height: 16,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: SphereShopColors.baseShimmerColor,
            highlightColor: SphereShopColors.baseShimmerHighlightColor,
            child: Container(
              height: 16,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

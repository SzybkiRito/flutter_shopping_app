import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/constants/colors.dart';

class ProductImageShimmer extends StatelessWidget {
  const ProductImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: SphereShopColors.baseShimmerColor,
      highlightColor: SphereShopColors.baseShimmerHighlightColor,
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

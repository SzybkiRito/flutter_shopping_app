import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class TopRoundedContainer extends StatelessWidget {
  final Widget child;
  const TopRoundedContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: SphereShopColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

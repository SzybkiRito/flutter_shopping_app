import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class SphereShopElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  const SphereShopElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? SphereShopColors.primaryColor,
            ),
          ),
      child: child,
    );
  }
}

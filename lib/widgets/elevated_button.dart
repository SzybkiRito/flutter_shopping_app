import 'package:flutter/material.dart';

class SphereShopElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const SphereShopElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style,
      child: child,
    );
  }
}

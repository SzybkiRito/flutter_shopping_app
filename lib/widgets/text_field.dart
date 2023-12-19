import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class SphereShopTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textController;
  final void Function(String)? onChanged;
  const SphereShopTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: false,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: SphereShopColors.primaryColor,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: SphereShopColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: SphereShopColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

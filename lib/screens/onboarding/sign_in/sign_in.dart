import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SphereShopColors.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_transparent.png',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.red,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: SphereShopColors.white,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: SphereShopColors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: SphereShopColors.white,
                  ),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.red,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: SphereShopColors.white,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: SphereShopColors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: SphereShopColors.white,
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

import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SphereShopColors.secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch across horizontal axis
          children: [
            Flexible(
              flex: 2, // Adjust flex factor as needed
              child: Image.asset(
                'assets/images/logo_transparent.png',
                fit: BoxFit.contain,
                height: 250,
                width: 150,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Let\'s get started!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/sign_in');
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        'START',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: SphereShopColors.white,
                            ),
                      ),
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

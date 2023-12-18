import 'package:flutter/material.dart';
import 'package:shopping_app/screens/home/home.dart';
import 'package:shopping_app/screens/main_page.dart';
import 'package:shopping_app/screens/onboarding/onboarding.dart';
import 'package:shopping_app/screens/onboarding/sign_in/sign_in.dart';
import 'package:shopping_app/theme/theme.dart';
import 'package:shopping_app/widgets/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopSphere',
      theme: shopTheme,
      home: SignIn(),
    );
  }
}

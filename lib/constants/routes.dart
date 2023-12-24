import 'package:flutter/widgets.dart';
import 'package:shopping_app/screens/main_page.dart';
import 'package:shopping_app/screens/onboarding/sign_in/sign_in.dart';
import 'package:shopping_app/screens/onboarding/sign_up/sign_up.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/sign_in': (context) => const SignIn(),
  '/sign_up': (context) => const SignUp(),
  '/main_page': (context) => const MainPage(),
};

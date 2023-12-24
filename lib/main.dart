import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:shopping_app/constants/routes.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/screens/onboarding/onboarding.dart';
import 'package:shopping_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        )
      ],
      child: MaterialApp(
        title: 'ShopSphere',
        theme: shopTheme,
        routes: routes,
        home: const OnBoarding(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/widgets/elevated_button.dart';
import 'package:shopping_app/widgets/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  SphereShopElevatedButton _buildButton(String text) {
    return SphereShopElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: SphereShopColors.secondaryColor,
              fontSize: 24,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double defaultEdgePadding = 8.0;
    return Scaffold(
      backgroundColor: SphereShopColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultEdgePadding),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 250,
                  width: 150,
                  child: Image.asset(
                    'assets/images/logo_transparent.png',
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SphereShopTextField(hintText: 'Email', textController: _emailTextController),
              const SizedBox(height: 10.0),
              SphereShopTextField(
                hintText: 'Password',
                obscureText: true,
                textController: _passwordTextController,
              ),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('Sign In'),
                  const SizedBox(height: 10.0),
                  _buildButton('Sign Up'),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: SphereShopColors.primaryColor,
                          thickness: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: SphereShopColors.primaryColor),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Divider(
                          color: SphereShopColors.primaryColor,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultEdgePadding),
                    child: SphereShopElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/google_logo_transparent.png',
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            'Sign In with Google',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: SphereShopColors.secondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

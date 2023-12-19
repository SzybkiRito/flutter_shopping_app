import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_events.dart';
import 'package:shopping_app/bloc/authentication/authentication_state.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/screens/onboarding/sign_in/sign_in.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/widgets/elevated_button.dart';
import 'package:shopping_app/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  SphereShopElevatedButton _buildButton(String text, {required VoidCallback onPressed}) {
    return SphereShopElevatedButton(
      onPressed: onPressed,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: SphereShopColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultEdgePadding),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              }
              return Column(
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
                  SphereShopTextField(
                    hintText: 'Email',
                    textController: _emailTextController,
                  ),
                  const SizedBox(height: 10.0),
                  SphereShopTextField(
                    hintText: 'Password',
                    obscureText: true,
                    textController: _passwordTextController,
                  ),
                  const SizedBox(height: 10.0),
                  SphereShopTextField(
                    hintText: 'Confirm Password',
                    obscureText: true,
                    textController: _confirmPasswordTextController,
                  ),
                  const SizedBox(height: 10.0),
                  state is AuthenticationFailure
                      ? Text(
                          state.errorMessage,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
                        )
                      : const SizedBox(
                          height: 30.0,
                        ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      state is! AuthenticationLoading
                          ? _buildButton('Sign Up', onPressed: () {
                              context.read<AuthenticationBloc>().add(
                                    AuthenticationSignUpRequested(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
                                      confirmPassword: _confirmPasswordTextController.text,
                                    ),
                                  );
                            })
                          : SphereShopElevatedButton(
                              onPressed: () {},
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: SphereShopColors.secondaryColor,
                                ),
                              ),
                            ),
                      const SizedBox(height: 10.0),
                      _buildButton('Sign In', onPressed: () {}),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

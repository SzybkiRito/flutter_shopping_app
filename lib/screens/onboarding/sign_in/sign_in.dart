import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_events.dart';
import 'package:shopping_app/bloc/authentication/authentication_state.dart';
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
              if (state is AuthenticationSignInSuccess) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacementNamed('/main_page');
                });
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
                  SphereShopTextField(hintText: 'Email', textController: _emailTextController),
                  const SizedBox(height: 10.0),
                  SphereShopTextField(
                    hintText: 'Password',
                    obscureText: true,
                    textController: _passwordTextController,
                  ),
                  const SizedBox(height: 10.0),
                  state is AuthenticationSignInFailure
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
                      state is! AuthenticationSignInLoading
                          ? _buildButton('Sign In', onPressed: () {
                              context.read<AuthenticationBloc>().add(
                                    AuthenticationSignInRequested(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
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
                      _buildButton('Sign Up', onPressed: () {
                        Navigator.of(context).pushNamed('/sign_up');
                      }),
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
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: SphereShopColors.primaryColor),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

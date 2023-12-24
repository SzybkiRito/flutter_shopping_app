class AuthenticationEvent {}

class AuthenticationSignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationSignInRequested({required this.email, required this.password});
}

class AuthenticationSignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthenticationSignUpRequested({required this.email, required this.password, required this.confirmPassword});
}

class AuthenticationGoogleSignInRequested extends AuthenticationEvent {}

class AuthenticationResetState extends AuthenticationEvent {}

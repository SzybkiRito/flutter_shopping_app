abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSignUpLoading extends AuthenticationState {}

class AuthenticationSignUpSuccess extends AuthenticationState {}

class AuthenticationSignInInitial extends AuthenticationState {}

class AuthenticationSignInLoading extends AuthenticationState {}

class AuthenticationSignInSuccess extends AuthenticationState {}

class AuthenticationSignInFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationSignInFailure({required this.errorMessage});
}

class AuthenticationSignUpFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationSignUpFailure({required this.errorMessage});
}

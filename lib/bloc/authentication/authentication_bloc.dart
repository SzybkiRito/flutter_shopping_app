import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_events.dart';
import 'package:shopping_app/bloc/authentication/authentication_state.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/services/service_locator.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_onSignInRequested);
    on<AuthenticationSignUpRequested>(_onSignUpRequested);
  }

  final Authentication _authentication = serviceLocator<Authentication>();
  void _onSignInRequested(AuthenticationSignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSignInLoading());
    final AuthenticationInfo authenticationInfo = await _authentication.signIn(
      event.email,
      event.password,
    );

    if (authenticationInfo.success) {
      emit(AuthenticationSignInSuccess());
    } else {
      // Error message can't be null cause success is false
      final String fixedErrorMessage = authenticationInfo.errorMessage!.replaceAll('-', ' ');
      emit(AuthenticationSignInFailure(errorMessage: fixedErrorMessage));
    }
  }

  void _onSignUpRequested(AuthenticationSignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSignUpLoading());
    bool passwordsMatch = event.password == event.confirmPassword;
    if (!passwordsMatch) {
      emit(AuthenticationSignUpFailure(errorMessage: 'Passwords do not match.'));
      return;
    }

    final AuthenticationInfo authenticationInfo = await _authentication.signUp(
      event.email,
      event.password,
    );

    if (authenticationInfo.success) {
      emit(AuthenticationSignUpSuccess());
    } else {
      // Error message can't be null cause success is false
      emit(AuthenticationSignUpFailure(errorMessage: authenticationInfo.errorMessage!));
    }
  }
}

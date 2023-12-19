import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/authentication/authentication_events.dart';
import 'package:shopping_app/bloc/authentication/authentication_state.dart';
import 'package:shopping_app/services/authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_onSignInRequested);
    on<AuthenticationSignUpRequested>(_onSignUpRequested);
  }

  void _onSignInRequested(AuthenticationSignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final AuthenticationInfo authenticationInfo = await Authentication().signIn(
      event.email,
      event.password,
    );

    if (authenticationInfo.success) {
      emit(AuthenticationSuccess());
    } else {
      // Error message can't be null cause success is false
      emit(AuthenticationFailure(errorMessage: authenticationInfo.errorMessage!));
    }
  }

  void _onSignUpRequested(AuthenticationSignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    bool passwordsMatch = event.password == event.confirmPassword;
    if (!passwordsMatch) {
      emit(AuthenticationFailure(errorMessage: 'Passwords do not match.'));
      return;
    }

    final AuthenticationInfo authenticationInfo = await Authentication().signUp(
      event.email,
      event.password,
    );

    if (authenticationInfo.success) {
      emit(AuthenticationSuccess());
    } else {
      // Error message can't be null cause success is false
      emit(AuthenticationFailure(errorMessage: authenticationInfo.errorMessage!));
    }
  }
}

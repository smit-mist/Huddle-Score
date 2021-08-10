import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository;
  LoginBloc({AuthRepository authRepository})
      : _repository = authRepository,
        super(LoginInitial(false, false, false));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    print(event);
    if (event is LoginButtonPressed) {
      yield LoginLoading(true, true, false);
      try {
        User user = await _repository.signIn(event.email, event.password);
        yield LoginSuccess(
            user: user,
            emailTapped: true,
            passwordTapped: true,
            obscureText: false);
      } catch (e) {
        yield LoginFailure(
            message: e.toString(),
            emailTapped: true,
            passwordTapped: true,
            obscureText: false);
      }
    }
    else if(event is EmailFieldPressed){
      state.emailTapped = true;
      yield state;
    }
    else if(event is PasswordFieldPressed){
      state.passwordTapped = true;
      yield state;
    }
    else if(event is ObscureTextPressed){
      state.obscureText = !state.obscureText;
      yield state;
    }
  }
}

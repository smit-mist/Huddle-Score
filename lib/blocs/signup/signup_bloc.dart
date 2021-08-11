import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _repository;
  SignupBloc({AuthRepository authRepository})
      : _repository = authRepository,
        super(SignupInitial(false, false, false, false, false));

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      try {
        yield SignUpLoading(true, true, false, true, true);
        User user =
            await _repository.signUp(event.email, event.password, event.name);
        yield SignUpSuccess(
          user: user,
          emailTapped: true,
          passwordTapped: true,
          obscureText: false,
          nameTapped: true,
          confirmPasswordTapped: true,
        );
      } catch (e) {
        yield SignUpFailure(
            message: e.toString(),
            nameTapped: true,
            emailTapped: true,
            confirmPasswordTapped: true,
            passwordTapped: true,
            obscureText: false);
      }
    } else if (event is NameOnTap) {
      state.nameTapped = true;
      yield state;
    } else if (event is EmailOnTap) {
      state.emailTapped = true;
      yield state;
    } else if (event is PasswordOnTap) {
      state.passwordTapped = true;
      yield state;
    } else if (event is ConfirmPasswordOnTap) {
      state.confirmPasswordTapped = true;
      yield state;
    } else if (event is ObscureTextOnTap) {
      state.obscureText = true;
      yield state;
    }
  }
}

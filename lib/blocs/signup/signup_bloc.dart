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
        super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    try {
      if (event is SignUpButtonPressed) {
        yield SignUpLoading();
        User user =
            await _repository.signUp(event.email, event.password, event.name);
        yield SignUpSuccess(user: user);
      }
    } catch (e) {
      yield SignUpFailure(message:e.toString());
    }
  }
}

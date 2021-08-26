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
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        User user = await _repository.signIn(event.email, event.password);
        yield LoginSuccess(
          user: user,
        );
      } catch (e) {
        yield LoginFailure(
          message: e.toString(),
        );
      }
    }
    yield LoginInitial();
  }
}

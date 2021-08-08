import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _repository;
  AuthBloc({AuthRepository authRepository})
      : _repository = authRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      try {
        final bool isSignIn = await _repository.isSignedIn();
        if (isSignIn) {
          yield Authenticated(user: await _repository.getCurrentUser());
        } else {
          yield UnAuthenticated();
        }
      } catch (e) {
        yield UnAuthenticated();
      }
    }
  }
}

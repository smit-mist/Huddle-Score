import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/signInBloc/signIn_event.dart';
import 'package:huddle_and_score/blocs/signInBloc/signIn_state.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

class SignInBLoc extends Bloc<SignInEvent, SignInState> {
  AuthRepository authRepository;
  SignInBLoc({@required this.authRepository}) : super(SignInInitialState());
  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInButtonPressed) {
      try {
        yield SignInLoadingState();
        var user = await authRepository.signIn(
          event.email,
          event.password,
        );
        yield SignInSuccessState(user: user);
      } catch (e) {
        yield SignInFailureState(errorMsg: e.toString());
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/authBloc/auth_event.dart';
import 'package:huddle_and_score/blocs/authBloc/auth_state.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({@required this.authRepository}) : super(AuthInitialState());
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppInitialized) {
      try {
        var isSignIn = await authRepository.isSignedIn();
        if (isSignIn) {
          var user = await authRepository.getCurrentUser();
          yield AuthenticatedState(user: user);
        } else
          yield UnAuthenticatedState();
      } on PlatformException catch (e) {
        throw Exception(e.toString());
      }
    }
  }
}

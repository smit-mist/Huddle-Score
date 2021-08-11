import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _repository;
  ForgotPasswordBloc({AuthRepository authRepository})
      : _repository = authRepository,
        super(ForgotPasswordInitial(false));

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordInitiated) {
      print('loading');
      yield ForgotPasswordLoadingState(true);
      try {
        await _repository.sendPasswordResetEmail(event.email);
        print('success');
        yield ForgotPasswordSuccessState(true);
      } catch (e) {
        print('failure');
        yield ForgotPasswordFailureState(false);
      }
    } else if (event is onEmailChanged) {
      state.emailTap = true;
      yield state;
    }
  }
}

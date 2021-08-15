import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _repository;
  UserBloc(UserRepository userRepository)
      : _repository = UserRepository(),
        super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is NameUpdatedEvent) {
      yield LoadingState();
      try {
        await _repository.changeUserName(event.name);
        yield NameUpdatedState();
      } catch (e) {
        yield FailureState();
      }
    }else if(event is EmailUpdatedEvent){
      yield LoadingState();
      try {
        await _repository.changeUserName(event.email);
        yield EmailUpdatedState();
      } catch (e) {
        yield FailureState();
      }
    }else if(event is PasswordUpdatedEvent){
      yield LoadingState();
      try {
        await _repository.changeUserName(event.password);
        yield PasswordUpdatedState();
      } catch (e) {
        yield FailureState();
      }
    }
  }
}

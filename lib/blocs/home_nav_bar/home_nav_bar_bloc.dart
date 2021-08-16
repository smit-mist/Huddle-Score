import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';

part 'home_nav_bar_event.dart';
part 'home_nav_bar_state.dart';

class HomeNavBarBloc extends Bloc<HomeNavBarEvent, HomeNavBarState> {
  final AuthRepository _repository;
  HomeNavBarBloc({AuthRepository authRepository})
      : _repository = authRepository,
        super(HomeNavBarInitial());

  @override
  Stream<HomeNavBarState> mapEventToState(
    HomeNavBarEvent event,
  ) async* {
    print(state);
    if (event is HomeIconPressed) {
      yield HomeScreenState();
    } else if (event is SearchIconPressed) {
      yield SearchScreenState();
    } else if (event is CartIconPressed) {
      yield CartScreenState();
    } else if (event is ProfileIconPressed) {
      final isSignedIn = await _repository.isSignedIn();
      if (isSignedIn) {
        final User user = await _repository.getCurrentUser();
        print(user.email);
        print(user.displayName);
        yield UserProfileScreenState(
          email: user.email,
          name: user.displayName,
        );
      } else
        yield AnonymousProfileScreenState();
    }
  }
}

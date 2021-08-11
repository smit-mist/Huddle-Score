import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_nav_bar_event.dart';
part 'home_nav_bar_state.dart';

class HomeNavBarBloc extends Bloc<HomeNavBarEvent, HomeNavBarState> {
  HomeNavBarBloc() : super(HomeNavBarInitial());

  @override
  Stream<HomeNavBarState> mapEventToState(
    HomeNavBarEvent event,
  ) async* {
    if (event is HomeIconPressed) {
      yield HomeScreenState();
    } else if (event is SearchIconPressed) {
      yield SearchScreenState();
    } else if (event is CartIconPressed) {
      yield CartScreenState();
    } else if (event is ProfileIconPressed) {
      yield ProfileScreenState();
    }
  }
}

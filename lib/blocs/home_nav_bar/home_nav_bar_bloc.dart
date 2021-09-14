import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/fifa_booking.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/user_repository.dart';

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
    final isSignedIn = await _repository.isSignedIn();
    if (event is HomeIconPressed) {
      yield HomeScreenState();
    } else if (event is SearchIconPressed) {
      yield SearchScreenState();
    } else if (event is CartIconPressed) {
      if (isSignedIn) {
        List<BookingDetails> bookings = await UserRepository().getBookings();
        List<FifaBookingDetails> fifas =
            await UserRepository().getFifaBookings();
        print("Qg3");
        print(bookings == null);
      //  print(bookings.length);
      //  print(fifas.length);
        yield CartScreenState(bookings: bookings,fifaBookings: fifas);
      } else {
        yield GuestCartScreenState();
      }
    } else if (event is ProfileIconPressed) {
      if (isSignedIn) {
        final User user = _repository.getCurrentUser();
        yield UserProfileScreenState(
          email: user.email,
          name: user.displayName,
        );
      } else
        yield AnonymousProfileScreenState();
    }
  }
}

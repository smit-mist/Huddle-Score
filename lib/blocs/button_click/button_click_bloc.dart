import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'button_click_event.dart';
part 'button_click_state.dart';

class ButtonClickBloc extends Bloc<ButtonClickEvent, ButtonClickState> {
  ButtonClickBloc() : super(ButtonClickInitial());

  @override
  Stream<ButtonClickState> mapEventToState(
    ButtonClickEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is TournamentDetailExpanded){
        state.tournamentDetailExpanded = !state.tournamentDetailExpanded;
        print("Inside");
        print(state.tournamentDetailExpanded);

        yield state;
    }
    print("outside");
    print(state.tournamentDetailExpanded);
    yield state;
  }
}

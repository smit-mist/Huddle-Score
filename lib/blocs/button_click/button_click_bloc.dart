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
    if (event is TournamentDetailExpanded) {
      state.tournamentDetailExpanded = !state.tournamentDetailExpanded;
      if (state.tournamentDetailExpanded) {
        yield ExpandedState();
      } else
        yield UnExpandedState();
    }
  }
}

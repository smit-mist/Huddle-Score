part of 'button_click_bloc.dart';

abstract class ButtonClickEvent extends Equatable {
  const ButtonClickEvent();
  @override
  List<Object> get props => [];
}

class TournamentDetailExpanded extends ButtonClickEvent{

}

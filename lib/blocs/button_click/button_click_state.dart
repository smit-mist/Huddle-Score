part of 'button_click_bloc.dart';

abstract class ButtonClickState extends Equatable {
  bool tournamentDetailExpanded;
  ButtonClickState({this.tournamentDetailExpanded=false});
  @override
  List<Object> get props => [];
}

class ButtonClickInitial extends ButtonClickState {

}

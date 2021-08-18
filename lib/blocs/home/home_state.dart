import 'package:equatable/equatable.dart';
import 'package:huddle_and_score/models/home_event.dart';

abstract class HomeState extends Equatable {
  List<HomeTour> allTournaments;
  List<HomeFifa> allFifa;
  HomeState({this.allTournaments, this.allFifa});

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  Success(List<HomeTour> allTouranments, List<HomeFifa> allFifa)
      : super(allTournaments: allTouranments, allFifa: allFifa);
}

class Failure extends HomeState {}

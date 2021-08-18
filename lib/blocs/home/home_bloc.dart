import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/repositories/home_repository.dart';

import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  HomeBloc({HomeRepository homeRepository})
      : _repository = homeRepository,
        super(InitialState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is AppStart){
      try{
        yield Loading();
        List<HomeTour> tour= await _repository.fetchTours();
        List<HomeFifa> fifa= await _repository.fetchFifas();
        yield Success(tour,fifa);
      }catch(e){
        yield Failure();
      }
    }
  }
}

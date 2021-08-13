part of 'home_nav_bar_bloc.dart';

abstract class HomeNavBarState extends Equatable {
  const HomeNavBarState();
  @override
  List<Object> get props => [];
}

class HomeNavBarInitial extends HomeNavBarState {}

class HomeScreenState extends HomeNavBarState {}

class SearchScreenState extends HomeNavBarState {}

class CartScreenState extends HomeNavBarState {}

class UserProfileScreenState extends HomeNavBarState {
  final String email, name;
  UserProfileScreenState({this.email, this.name}) : super();
}

class AnonymousProfileScreenState extends HomeNavBarState {}

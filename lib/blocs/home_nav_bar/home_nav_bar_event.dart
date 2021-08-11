part of 'home_nav_bar_bloc.dart';

abstract class HomeNavBarEvent extends Equatable {
  const HomeNavBarEvent();
  @override
  List<Object> get props => [];
}

class HomeIconPressed extends HomeNavBarEvent {}

class SearchIconPressed extends HomeNavBarEvent {}

class CartIconPressed extends HomeNavBarEvent {}

class ProfileIconPressed extends HomeNavBarEvent {}

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoadingState extends UserState{}


class EmailUpdatedState extends UserState{}

class NameUpdatedState extends UserState{}

class PasswordUpdatedState extends UserState{}

class FailureState extends UserState{}
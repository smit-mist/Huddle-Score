part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess({this.user});
}

class LoginFailure extends LoginState {
  String message;
  LoginFailure({this.message});
}

class LoginLoading extends LoginState {}

part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitiated extends ForgotPasswordEvent {
  String email;
  ForgotPasswordInitiated({this.email});
}

class onEmailChanged extends ForgotPasswordEvent {}

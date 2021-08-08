part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {
  final User user;

  SignUpSuccess({this.user});
}

class SignUpFailure extends SignupState {
  final String message;

  SignUpFailure({this.message});
}

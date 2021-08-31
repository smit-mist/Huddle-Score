part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  SignupState();
  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpSuccess extends SignupState {
  final User user;
  SignUpSuccess({
    this.user,
  });
}

class SignUpFailure extends SignupState {
  String message;
  SignUpFailure({
    this.message,
  });
}

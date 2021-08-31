part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignupEvent {
  String email, password, name;
  SignUpButtonPressed({this.email, this.name, this.password});
}

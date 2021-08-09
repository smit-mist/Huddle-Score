part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  String email, password;
  LoginButtonPressed({this.email, this.password});
}

class EmailFieldPressed extends LoginEvent{
  EmailFieldPressed();
}
class PasswordFieldPressed extends LoginEvent{
  PasswordFieldPressed();
}
class ObscureTextPressed extends LoginEvent{
  ObscureTextPressed();
}


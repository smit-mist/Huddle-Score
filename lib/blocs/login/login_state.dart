part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  bool emailTapped, passwordTapped, obscureText;
  LoginState({this.obscureText, this.emailTapped, this.passwordTapped});

  @override
  List<Object> get props => [obscureText, emailTapped, passwordTapped];
}

class LoginInitial extends LoginState {
  LoginInitial(bool emailTapped, bool passwordTapped, bool obscureText)
      : super(
            emailTapped: emailTapped,
            passwordTapped: passwordTapped,
            obscureText: obscureText);
}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(
      {this.user, bool emailTapped, bool passwordTapped, bool obscureText})
      : super(
            emailTapped: emailTapped,
            passwordTapped: passwordTapped,
            obscureText: obscureText);
}

class LoginFailure extends LoginState {
  String message;
  LoginFailure(
      {this.message, bool emailTapped, bool passwordTapped, bool obscureText})
      : super(
            emailTapped: emailTapped,
            passwordTapped: passwordTapped,
            obscureText: obscureText);
}

class LoginLoading extends LoginState {
  LoginLoading(bool emailTapped, bool passwordTapped, bool obscureText)
      : super(
            emailTapped: emailTapped,
            passwordTapped: passwordTapped,
            obscureText: obscureText);
}

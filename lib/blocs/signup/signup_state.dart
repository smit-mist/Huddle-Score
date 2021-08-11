part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  bool emailTapped,
      passwordTapped,
      obscureText,
      nameTapped,
      confirmPasswordTapped;
  SignupState({
    this.obscureText,
    this.passwordTapped,
    this.emailTapped,
    this.nameTapped,
    this.confirmPasswordTapped,
  });
  @override
  List<Object> get props => [
        emailTapped,
        passwordTapped,
        obscureText,
        nameTapped,
        confirmPasswordTapped,
      ];
}

class SignupInitial extends SignupState {
  SignupInitial(bool emailTapped, bool passwordTapped, bool obscureText,
      bool nameTapped, bool confirmPasswordTapped)
      : super(
          emailTapped: emailTapped,
          passwordTapped: passwordTapped,
          obscureText: obscureText,
          nameTapped: nameTapped,
          confirmPasswordTapped: confirmPasswordTapped,
        );
}

class SignUpLoading extends SignupState {
  SignUpLoading(bool emailTapped, bool passwordTapped, bool obscureText,
      bool nameTapped, bool confirmPasswordTapped)
      : super(
          emailTapped: emailTapped,
          passwordTapped: passwordTapped,
          obscureText: obscureText,
          nameTapped: nameTapped,
          confirmPasswordTapped: confirmPasswordTapped,
        );
}

class SignUpSuccess extends SignupState {
  final User user;
  SignUpSuccess(
      {this.user,
      bool emailTapped,
      bool passwordTapped,
      bool obscureText,
      bool nameTapped,
      bool confirmPasswordTapped})
      : super(
          emailTapped: emailTapped,
          passwordTapped: passwordTapped,
          obscureText: obscureText,
          nameTapped: nameTapped,
          confirmPasswordTapped: confirmPasswordTapped,
        );
}

class SignUpFailure extends SignupState {
  String message;
  SignUpFailure(
      {this.message,
      bool emailTapped,
      bool passwordTapped,
      bool obscureText,
      bool confirmPasswordTapped,
      bool nameTapped})
      : super(
          emailTapped: emailTapped,
          confirmPasswordTapped: confirmPasswordTapped,
          passwordTapped: passwordTapped,
          obscureText: obscureText,
          nameTapped: nameTapped,
        );
}

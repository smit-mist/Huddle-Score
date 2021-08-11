part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  bool emailTap;
  ForgotPasswordState({this.emailTap});
  @override
  List<Object> get props => [emailTap];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial(bool isEmail) : super(emailTap: isEmail);
}

class ForgotPasswordLoadingState extends ForgotPasswordState {
  ForgotPasswordLoadingState(bool isEmail) : super(emailTap: isEmail);
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  ForgotPasswordSuccessState(bool isEmail) : super(emailTap: isEmail);
}

class ForgotPasswordFailureState extends ForgotPasswordState {
  ForgotPasswordFailureState(bool isEmail) : super(emailTap: isEmail);
}
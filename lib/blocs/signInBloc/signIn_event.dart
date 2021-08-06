import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignInEvent extends Equatable{}

class SignInButtonPressed extends SignInEvent {
  String email, password;
  SignInButtonPressed({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

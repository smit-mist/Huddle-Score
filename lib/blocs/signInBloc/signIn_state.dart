import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class SignInState extends Equatable{}

class SignInInitialState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignInLoadingState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignInSuccessState extends SignInState {
  User user;
  SignInSuccessState({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignInFailureState extends SignInState {
  String errorMsg;
  SignInFailureState({@required this.errorMsg});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

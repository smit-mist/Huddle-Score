import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{}

class AppInitialized extends AuthEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
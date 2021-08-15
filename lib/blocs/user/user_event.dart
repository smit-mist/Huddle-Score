part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class NameUpdatedEvent extends UserEvent {
  String name;
  NameUpdatedEvent({this.name});
}

class EmailUpdatedEvent extends UserEvent {
  String email;
  EmailUpdatedEvent({this.email});
}

class PasswordUpdatedEvent extends UserEvent {
  String password;
  PasswordUpdatedEvent({this.password});
}

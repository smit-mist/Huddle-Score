part of 'forms_bloc.dart';

abstract class FormsState extends Equatable {
  const FormsState();
  
  @override
  List<Object> get props => [];
}

class FormsInitial extends FormsState {}

class FormsLoading extends FormsState{}

class FormsSubmitted extends FormsState{}
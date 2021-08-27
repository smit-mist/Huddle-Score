part of 'forms_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();

  @override
  List<Object> get props => [];
}

class PartnerTurfSubmit extends FormsEvent {
  final PartnerDetailsTurf detailsTurf;
  PartnerTurfSubmit({this.detailsTurf});
}

class PartnerTourSubmit extends FormsEvent {
  final PartnerDetailsTour detailsTour;
  PartnerTourSubmit({this.detailsTour});
}

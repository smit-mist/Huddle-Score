import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:huddle_and_score/models/partner_details.dart';
import 'package:huddle_and_score/repositories/partner_repository.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  final PartnerRepository _repository;
  FormsBloc(PartnerRepository partnerRepository)
      : _repository = partnerRepository,
        super(FormsInitial());

  @override
  Stream<FormsState> mapEventToState(
    FormsEvent event,
  ) async* {
    if (event is PartnerTourSubmit) {
      yield FormsLoading();
      try {
        await _repository.submitPartnerDetailsForTour(event.detailsTour);
      } catch (e) {
        throw Exception(e.toString());
      }
      yield FormsSubmitted();
    } else if (event is PartnerTurfSubmit) {
      yield FormsLoading();
      try {
        await _repository.submitPartnerDetailsForTurf(event.detailsTurf);
      } catch (e) {
        throw Exception(e.toString());
      }
      yield FormsSubmitted();
    }
  }
}

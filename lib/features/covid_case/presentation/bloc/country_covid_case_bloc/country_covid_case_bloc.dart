import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'country_covid_case_event.dart';
part 'country_covid_case_state.dart';

class CountryCovidCaseBloc extends Bloc<CountryCovidCaseEvent, CountryCovidCaseState> {
  CountryCovidCaseBloc() : super(CountryCovidCaseInitial());

  @override
  Stream<CountryCovidCaseState> mapEventToState(
    CountryCovidCaseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

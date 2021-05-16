import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/covid_case.dart';
import '../../../domain/usecases/get_country_covid_case.dart';

part 'country_covid_case_event.dart';
part 'country_covid_case_state.dart';

class CountryCovidCaseBloc
    extends Bloc<CountryCovidCaseEvent, CountryCovidCaseState> {
  CountryCovidCaseBloc({@required GetCountryCovidCase country})
      : assert(country != null),
        getCountryCovidCase = country,
        super(CountryCovidCaseInitial());

  final GetCountryCovidCase getCountryCovidCase;

  @override
  Stream<CountryCovidCaseState> mapEventToState(
    CountryCovidCaseEvent event,
  ) async* {
    if (event is GetCountryCovidCaseEvent) {
      yield CountryCovidCaseLoading();
      final result = await getCountryCovidCase(NoParams());
      yield result.fold(
        (failure) => CountryCovidCaseFailed(
          message: failure.mapFailureToMessage,
        ),
        (covidCase) => CountryCovidCaseLoaded(covidCase: covidCase),
      );
    }
  }
}

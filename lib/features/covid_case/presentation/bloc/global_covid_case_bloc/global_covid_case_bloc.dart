import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/covid_case.dart';
import '../../../domain/usecases/get_global_covid_case.dart';

part 'global_covid_case_event.dart';
part 'global_covid_case_state.dart';

const String SERVER_FAILURE_MESSAGE =
    'Server Failed. Please try again after some time.';
const String CACHE_FAILURE_MESSAGE =
    'Failed to show data from Cache. Please turn on your wifi.';

class GlobalCovidCaseBloc
    extends Bloc<GlobalCovidCaseEvent, GlobalCovidCaseState> {
  GlobalCovidCaseBloc({@required GetGlobalCovidCase global})
      : assert(global != null),
        getGlobalCovidCase = global,
        super(GlobalCovidCaseInitial());

  final GetGlobalCovidCase getGlobalCovidCase;

  @override
  Stream<GlobalCovidCaseState> mapEventToState(
    GlobalCovidCaseEvent event,
  ) async* {
    if (event is GetGlobalCovidCaseEvent) {
      yield GlobalCovidCaseLoading();
      final result = await getGlobalCovidCase(NoParams());
      yield result.fold(
        (failure) => GlobalCovidCaseFailed(
          message: failure is ServerFailure
              ? SERVER_FAILURE_MESSAGE
              : CACHE_FAILURE_MESSAGE,
        ),
        (covidCase) => GlobalCovidCaseLoaded(covidCase: covidCase),
      );
    }
  }
}

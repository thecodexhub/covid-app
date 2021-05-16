import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/covid_case.dart';
import '../../../domain/usecases/get_global_covid_case.dart';

part 'global_covid_case_event.dart';
part 'global_covid_case_state.dart';

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
          message: failure.mapFailureToMessage,
        ),
        (covidCase) => GlobalCovidCaseLoaded(covidCase: covidCase),
      );
    }
  }
}

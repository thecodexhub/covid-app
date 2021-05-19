import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_news/domain/usecases/get_global_covid_news.dart';
import 'package:covidapp/features/covid_news/domain/usecases/get_india_covid_news.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/covid_news.dart';
import 'package:covidapp/core/error/failure.dart';

part 'covid_news_event.dart';
part 'covid_news_state.dart';

class CovidNewsBloc extends Bloc<CovidNewsEvent, CovidNewsState> {
  CovidNewsBloc({
    @required GetGlobalCovidNews global,
    @required GetIndiaCovidNews india,
  })  : assert(global != null),
        assert(india != null),
        globalCovidNews = global,
        indiaCovidNews = india,
        super(CovidNewsInitial());

  final GetGlobalCovidNews globalCovidNews;
  final GetIndiaCovidNews indiaCovidNews;

  @override
  Stream<CovidNewsState> mapEventToState(
    CovidNewsEvent event,
  ) async* {
    if (event is GetGlobalCovidNewsEvent) {
      yield CovidNewsLoading();
      final result = await globalCovidNews(NoParams());
      yield result.fold(
        (failure) => CovidNewsFailed(message: failure.mapFailureToMessage),
        (covidNews) => CovidNewsLoaded(covidNews: covidNews),
      );
    } else if (event is GetIndiaCovidNewsEvent) {
      yield CovidNewsLoading();
      final result = await indiaCovidNews(NoParams());
      yield result.fold(
        (failure) => CovidNewsFailed(message: failure.mapFailureToMessage),
        (covidNews) => CovidNewsLoaded(covidNews: covidNews),
      );
    }
  }
}

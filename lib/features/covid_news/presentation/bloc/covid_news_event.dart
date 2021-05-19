part of 'covid_news_bloc.dart';

abstract class CovidNewsEvent extends Equatable {
  const CovidNewsEvent();

  @override
  List<Object> get props => [];
}

class GetGlobalCovidNewsEvent extends CovidNewsEvent {}

class GetIndiaCovidNewsEvent extends CovidNewsEvent {}

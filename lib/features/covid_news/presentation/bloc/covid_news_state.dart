part of 'covid_news_bloc.dart';

abstract class CovidNewsState extends Equatable {
  const CovidNewsState();

  @override
  List<Object> get props => [];
}

class CovidNewsInitial extends CovidNewsState {}

class CovidNewsLoading extends CovidNewsState {}

class CovidNewsLoaded extends CovidNewsState {
  CovidNewsLoaded({@required this.covidNews});
  final List<CovidNews> covidNews;

  @override
  List<Object> get props => [covidNews];
}

class CovidNewsFailed extends CovidNewsState {
  CovidNewsFailed({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

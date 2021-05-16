part of 'global_covid_case_bloc.dart';

abstract class GlobalCovidCaseState extends Equatable {
  const GlobalCovidCaseState();

  @override
  List<Object> get props => [];
}

class GlobalCovidCaseInitial extends GlobalCovidCaseState {}

class GlobalCovidCaseLoading extends GlobalCovidCaseState {}

class GlobalCovidCaseLoaded extends GlobalCovidCaseState {
  GlobalCovidCaseLoaded({@required this.covidCase});
  final CovidCase covidCase;

  @override
  List<Object> get props => [covidCase];
}

class GlobalCovidCaseFailed extends GlobalCovidCaseState {
  GlobalCovidCaseFailed({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

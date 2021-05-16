part of 'country_covid_case_bloc.dart';

abstract class CountryCovidCaseState extends Equatable {
  const CountryCovidCaseState();

  @override
  List<Object> get props => [];
}

class CountryCovidCaseInitial extends CountryCovidCaseState {}

class CountryCovidCaseLoading extends CountryCovidCaseState {}

class CountryCovidCaseLoaded extends CountryCovidCaseState {
  CountryCovidCaseLoaded({@required this.covidCase});
  final List<CovidCase> covidCase;

  @override
  List<Object> get props => [covidCase];
}

class CountryCovidCaseFailed extends CountryCovidCaseState {
  CountryCovidCaseFailed({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

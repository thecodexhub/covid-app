part of 'country_covid_case_bloc.dart';

abstract class CountryCovidCaseEvent extends Equatable {
  const CountryCovidCaseEvent();

  @override
  List<Object> get props => [];
}

class GetCountryCovidCaseEvent extends CountryCovidCaseEvent {}

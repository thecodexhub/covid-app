part of 'country_covid_case_bloc.dart';

abstract class CountryCovidCaseState extends Equatable {
  const CountryCovidCaseState();
  
  @override
  List<Object> get props => [];
}

class CountryCovidCaseInitial extends CountryCovidCaseState {}

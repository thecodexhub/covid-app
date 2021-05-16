part of 'global_covid_case_bloc.dart';

abstract class GlobalCovidCaseEvent extends Equatable {
  const GlobalCovidCaseEvent();

  @override
  List<Object> get props => [];
}

class GetGlobalCovidCaseEvent extends GlobalCovidCaseEvent {}

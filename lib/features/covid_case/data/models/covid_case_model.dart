import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:flutter/foundation.dart';

class CovidCaseModel extends CovidCase {
  CovidCaseModel({
    String country,
    @required int newConfirmed,
    @required int totalConfirmed,
    @required int newDeaths,
    @required int totalDeaths,
    @required int newRecovered,
    @required int totalRecovered,
    @required String updatedAt,
  }) : super(
          country: country,
          newConfirmed: newConfirmed,
          totalConfirmed: totalConfirmed,
          newDeaths: newDeaths,
          totalDeaths: totalDeaths,
          newRecovered: newRecovered,
          totalRecovered: totalRecovered,
          updatedAt: updatedAt,
        );

  CovidCaseModel copyWith({
    String country,
    int newConfirmed,
    int totalConfirmed,
    int newDeaths,
    int totalDeaths,
    int newRecovered,
    int totalRecovered,
  }) {
    return CovidCaseModel(
      country: country ?? this.country,
      newConfirmed: newConfirmed ?? this.newConfirmed,
      totalConfirmed: totalConfirmed ?? this.totalConfirmed,
      newDeaths: newDeaths ?? this.newDeaths,
      totalDeaths: totalDeaths ?? this.totalDeaths,
      newRecovered: newRecovered ?? this.newRecovered,
      totalRecovered: totalRecovered ?? this.totalRecovered,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CovidCaseModel.fromJson(Map<String, dynamic> json) {
    return CovidCaseModel(
      country: json['Country'] as String ?? 'Global',
      newConfirmed: json['NewConfirmed'] as int,
      totalConfirmed: json['TotalConfirmed'] as int,
      newDeaths: json['NewDeaths'] as int,
      totalDeaths: json['TotalDeaths'] as int,
      newRecovered: json['NewRecovered'] as int,
      totalRecovered: json['TotalRecovered'] as int,
      updatedAt: json['Date'] as String,
    );
  }

// Ignore: implicit_dynamic_map_literal
  Map<String, dynamic> toJson() {
    return {
      'Country': country,
      'NewConfirmed': newConfirmed,
      'TotalConfirmed': totalConfirmed,
      'NewDeaths': newDeaths,
      'TotalDeaths': totalDeaths,
      'NewRecovered': newRecovered,
      'TotalRecovered': totalRecovered,
      'Date': updatedAt
    };
  }
}

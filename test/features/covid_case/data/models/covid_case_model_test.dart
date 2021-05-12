import 'dart:convert';

import 'package:covidapp/features/covid_case/data/models/covid_case_model.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tCovidCaseModel = CovidCaseModel(
    country: 'Text test',
    newConfirmed: 1,
    totalConfirmed: 1,
    newDeaths: 1,
    totalDeaths: 1,
    newRecovered: 1,
    totalRecovered: 1,
    updatedAt: 'Text test',
  );

  test('should be a subclass of CovidCase entity', () async {
    // Assert
    expect(tCovidCaseModel, isA<CovidCase>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON case is global', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = json
          .decode(fixture('fixture_global_data.json')) as Map<String, dynamic>;
      // Act
      final CovidCaseModel result = CovidCaseModel.fromJson(jsonMap);
      // Assert
      expect(result, tCovidCaseModel.copyWith(country: 'Global'));
    });

    test('should return a valid model when the JSON case is country', () async {
      // Arrange
      final Map<String, dynamic> jsonMap = json
          .decode(fixture('fixture_country_data.json')) as Map<String, dynamic>;
      // Act
      final CovidCaseModel result = CovidCaseModel.fromJson(jsonMap);
      // Assert
      expect(result, tCovidCaseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // Act
      final Map<String, dynamic> result = tCovidCaseModel.toJson();
      // Assert
      final expectedMap = {
        "Country": "Text test",
        "NewConfirmed": 1,
        "TotalConfirmed": 1,
        "NewDeaths": 1,
        "TotalDeaths": 1,
        "NewRecovered": 1,
        "TotalRecovered": 1,
        "Date": "Text test",
      };
      expect(result, expectedMap);
    });
  });
}

import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/features/covid_case/data/datasources/covid_case_local_data_source.dart';
import 'package:covidapp/features/covid_case/data/models/covid_case_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  CovidCaseLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        CovidCaseLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastGlobalCovidCase', () {
    final tCovidCaseModel = CovidCaseModel.fromJson(
        json.decode(fixture('fixture_global_cached_data.json'))
            as Map<String, dynamic>);
    test(
        'should return CovidCaseModel from SharedPreferences when there is Global data in cache',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('fixture_global_cached_data.json'));
      // Act
      final result = await localDataSourceImpl.getLastGlobalCovidCase();
      // Assert
      verify(mockSharedPreferences.getString(CACHED_GLOBAL_COVID_CASE));
      expect(result, equals(tCovidCaseModel));
    });

    test('should throw a CacheException when there is no Global cache data',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // Act
      final call = localDataSourceImpl.getLastGlobalCovidCase;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('getLastCountryCovidCase', () {
    final tCovidCaseList = <CovidCaseModel>[];
    final decodedJson =
        json.decode(fixture('fixture_country_cached_data.json'));
    decodedJson.forEach((json) => tCovidCaseList
        .add(CovidCaseModel.fromJson(json as Map<String, dynamic>)));
    test(
        'should return List of CovidCaseModel from SharedPreferences when there is Country data in cache',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('fixture_country_cached_data.json'));
      // Act
      final result = await localDataSourceImpl.getLastCountryCovidCase();
      // Assert
      verify(mockSharedPreferences.getString(CACHED_COUNTRY_COVID_CASE));
      expect(result, equals(tCovidCaseList));
    });

    test('should throw a CacheException when there is no Country cache data',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // Act
      final call = localDataSourceImpl.getLastCountryCovidCase;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheGlobalCovidCase', () {
    final tCovidCaseModel = CovidCaseModel(
      country: 'test',
      newConfirmed: 1,
      totalConfirmed: 1,
      newDeaths: 1,
      totalDeaths: 1,
      newRecovered: 1,
      totalRecovered: 1,
      updatedAt: 'test',
    );
    test('should call SharedPreferences to cache Global data', () async {
      // Act
      await localDataSourceImpl.cacheGlobalCovidCase(tCovidCaseModel);
      // Assert
      final expectedJson = json.encode(tCovidCaseModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_GLOBAL_COVID_CASE,
        expectedJson,
      ));
    });
  });

  group('cacheCountryCovidCase', () {
    final tCovidCaseModel = [
      CovidCaseModel(
        country: 'test',
        newConfirmed: 1,
        totalConfirmed: 1,
        newDeaths: 1,
        totalDeaths: 1,
        newRecovered: 1,
        totalRecovered: 1,
        updatedAt: 'test',
      )
    ];
    final tCovidCaseJsonList = <Map<String, dynamic>>[];
    tCovidCaseModel.forEach((data) => tCovidCaseJsonList.add(data.toJson()));
    test('should call SharedPreferences to cache Country data', () async {
      // Act

      await localDataSourceImpl.cacheCountryCovidCase(tCovidCaseModel);
      // Assert
      final expectedJson = json.encode(tCovidCaseJsonList);
      verify(mockSharedPreferences.setString(
        CACHED_COUNTRY_COVID_CASE,
        expectedJson,
      ));
    });
  });
}

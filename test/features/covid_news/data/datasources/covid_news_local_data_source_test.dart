import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/features/covid_news/data/datasources/covid_news_local_data_source.dart';
import 'package:covidapp/features/covid_news/data/models/covid_news_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  CovidNewsLocalDataSourceImpl localDataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        CovidNewsLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastGlobalCovidNews', () {
    final tCovidNewsList = <CovidNewsModel>[];
    final decodedJson = json.decode(fixture('fixture_cached_news.json'));
    decodedJson.forEach((json) => tCovidNewsList
        .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
    test(
        'should return List of CovidNewsModel from SharedPreferences when there is global news in cache',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('fixture_cached_news.json'));
      // Act
      final result = await localDataSourceImpl.getLastGlobalCovidNews();
      // Assert
      verify(mockSharedPreferences.getString(CACHED_GLOBAL_COVID_NEWS));
      expect(result, tCovidNewsList);
    });

    test('should throw a CacheException when there is no global cache news',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // Act
      final call = localDataSourceImpl.getLastGlobalCovidNews;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('getLastIndiaCovidNews', () {
    final tCovidNewsList = <CovidNewsModel>[];
    final decodedJson = json.decode(fixture('fixture_cached_news.json'));
    decodedJson.forEach((json) => tCovidNewsList
        .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
    test(
        'should return List of CovidNewsModel from SharedPreferences when there is india news in cache',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('fixture_cached_news.json'));
      // Act
      final result = await localDataSourceImpl.getLastIndiaCovidNews();
      // Assert
      verify(mockSharedPreferences.getString(CACHED_INDIA_COVID_NEWS));
      expect(result, tCovidNewsList);
    });

    test('should throw a CacheException when there is no india cache news',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // Act
      final call = localDataSourceImpl.getLastIndiaCovidNews;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheGlobalCovidNews', () {
    final tCovidNewsModel = [
      CovidNewsModel(
        source: 'test',
        author: 'test',
        title: 'test',
        description: 'test',
        url: 'test',
        urlToImage: 'test',
        publishedAt: 'test',
      )
    ];
    final tCovidNewsJsonList = <Map<String, dynamic>>[];
    tCovidNewsModel.forEach((data) => tCovidNewsJsonList.add(data.toJson()));
    test('should call SharedPreferences to cache global news', () async {
      // Act
      await localDataSourceImpl.cacheGlobalCovidNews(tCovidNewsModel);
      // Assert
      final expectedJson = json.encode(tCovidNewsJsonList);
      verify(mockSharedPreferences.setString(
        CACHED_GLOBAL_COVID_NEWS,
        expectedJson,
      ));
    });
  });

  group('cacheIndiaCovidNews', () {
    final tCovidNewsModel = [
      CovidNewsModel(
        source: 'test',
        author: 'test',
        title: 'test',
        description: 'test',
        url: 'test',
        urlToImage: 'test',
        publishedAt: 'test',
      )
    ];
    final tCovidNewsJsonList = <Map<String, dynamic>>[];
    tCovidNewsModel.forEach((data) => tCovidNewsJsonList.add(data.toJson()));
    test('should call SharedPreferences to cache india news', () async {
      // Act
      await localDataSourceImpl.cacheIndiaCovidNews(tCovidNewsModel);
      // Assert
      final expectedJson = json.encode(tCovidNewsJsonList);
      verify(mockSharedPreferences.setString(
        CACHED_INDIA_COVID_NEWS,
        expectedJson,
      ));
    });
  });
}

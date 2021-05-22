import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/features/covid_news/data/datasources/covid_news_remote_data_source.dart';
import 'package:covidapp/features/covid_news/data/models/covid_news_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CovidNewsRemoteDataSourceImpl remoteDatasourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDatasourceImpl =
        CovidNewsRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('fixture_api_news.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getGlobalCovidNews', () {
    final tCovidNewsModelList = List<CovidNewsModel>.from(
        (json.decode(fixture('fixture_api_news.json'))["articles"] as List)
            .map((e) => CovidNewsModel.fromJson(e as Map<String, dynamic>)));
    test('should perform a GET request on a global covid news URL', () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      await remoteDatasourceImpl.getGlobalCovidNews();
      // Assert
      verify(mockHttpClient.get(Uri.parse(URI_FOR_GLOBAL_NEWS)));
    });

    test('should return a list of CovidNewsModel when the statusCode is 200',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      final result = await remoteDatasourceImpl.getGlobalCovidNews();
      // Assert
      expect(result, tCovidNewsModelList);
    });

    test('should throw ServerException when statusCode is other than 200',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = remoteDatasourceImpl.getGlobalCovidNews;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getIndiaCovidNews', () {
    final tCovidNewsModelList = List<CovidNewsModel>.from(
        (json.decode(fixture('fixture_api_news.json'))["articles"] as List)
            .map((e) => CovidNewsModel.fromJson(e as Map<String, dynamic>)));
    test('should perform a GET request on a india covid news URL', () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      await remoteDatasourceImpl.getIndiaCovidNews();
      // Assert
      verify(mockHttpClient.get(Uri.parse(URI_FOR_INDIA_NEWS)));
    });

    test('should return a list of CovidNewsModel when the statusCode is 200',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      final result = await remoteDatasourceImpl.getIndiaCovidNews();
      // Assert
      expect(result, tCovidNewsModelList);
    });

    test('should throw ServerException when statusCode is other than 200',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = remoteDatasourceImpl.getIndiaCovidNews;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}

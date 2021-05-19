import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/features/covid_case/data/datasources/covid_case_remote_data_source.dart';
import 'package:covidapp/features/covid_case/data/models/covid_case_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CovidCaseRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl =
        CovidCaseRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String fixtureString) {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture(fixtureString), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getGlobalCovidCase', () {
    final tCovidCaseModel = CovidCaseModel.fromJson(
        json.decode(fixture('fixture_api_data.json'))["Global"]
            as Map<String, dynamic>);
    test('should perform a GET request on a URL with the `summary` endpoint',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_data.json');
      // Act
      await remoteDataSourceImpl.getGlobalCovidCase();
      // Assert
      verify(mockHttpClient.get(Uri.parse(URI_FOR_COVID_CASE)));
    });

    test('should return a CovidCaseModel when the statusCode is 200', () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_data.json');
      // Act
      final result = await remoteDataSourceImpl.getGlobalCovidCase();
      // Assert
      expect(result, equals(tCovidCaseModel));
    });

    test('should throw ServerException when statusCode is other than 200',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = remoteDataSourceImpl.getGlobalCovidCase;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getCountryCovidCase', () {
    final tCovidCaseModelList = List<CovidCaseModel>.from(
        (json.decode(fixture('fixture_api_data.json'))["Countries"] as List)
            .map((e) => CovidCaseModel.fromJson(e as Map<String, dynamic>)));
    test('should perform a GET request on a URL with the `summary` endpoint',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_data.json');
      // Act
      await remoteDataSourceImpl.getCountryCovidCase();
      // Assert
      verify(mockHttpClient.get(Uri.parse(URI_FOR_COVID_CASE)));
    });

    test('should return a list of CovidCaseModel when the statusCode is 200',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200('fixture_api_data.json');
      // Act
      final result = await remoteDataSourceImpl.getCountryCovidCase();
      // Assert
      expect(result, equals(tCovidCaseModelList));
    });

    test('should throw ServerException when statusCode is other than 200',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = remoteDataSourceImpl.getCountryCovidCase;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}

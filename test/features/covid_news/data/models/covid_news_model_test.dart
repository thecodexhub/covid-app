import 'dart:convert';

import 'package:covidapp/features/covid_news/data/models/covid_news_model.dart';
import 'package:covidapp/features/covid_news/domain/entities/covid_news.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tCovidNewsModel = CovidNewsModel(
    source: 'test',
    author: 'test',
    title: 'test',
    description: 'test',
    url: 'test',
    urlToImage: 'test',
    publishedAt: 'test',
  );

  test('should be a subclass of CovidNews entity', () {
    // Assert
    expect(tCovidNewsModel, isA<CovidNews>());
  });

  group('fromJson', () {
    test('should return a valid model from the JSON data', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('fixture_news.json')) as Map<String, dynamic>;
      // Act
      final CovidNewsModel result = CovidNewsModel.fromJson(jsonMap);
      // Assert
      expect(result, tCovidNewsModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // Act
      final Map<String, dynamic> result = tCovidNewsModel.toJson();
      // Assert
      final expectedMap = {
        "source": {"name": "test"},
        "author": "test",
        "title": "test",
        "description": "test",
        "url": "test",
        "urlToImage": "test",
        "publishedAt": "test"
      };
      expect(result, expectedMap);
    });
  });
}

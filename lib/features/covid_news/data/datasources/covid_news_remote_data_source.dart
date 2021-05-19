import 'dart:convert';

import 'package:covidapp/api_key.dart';
import 'package:covidapp/core/error/exception.dart';
import 'package:flutter/foundation.dart';

import '../models/covid_news_model.dart';
import 'package:http/http.dart' as http;

abstract class CovidNewsRemoteDatasource {
  /// Calls the https://newsapi.org/v2/{endpoint} api with `top-headlines` endpoint.
  /// Parse the value into `CovidNewsModel`.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CovidNewsModel>> getGlobalCovidNews();

  /// Calls the https://newsapi.org/v2/{endpoint} api with `top-headlines` endpoint.
  /// Parse the value into `CovidNewsModel`. And the query parameter `country` is `in`.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CovidNewsModel>> getIndiaCovidNews();
}

const String URI_FOR_GLOBAL_NEWS =
    'https://newsapi.org/v2/top-headlines?category=health&apiKey=$NEWS_API_KEY&language=en&q=covid';
const String URI_FOR_INDIA_NEWS =
    'https://newsapi.org/v2/top-headlines?category=health&apiKey=$NEWS_API_KEY&country=in&language=en&q=covid';

class CovidNewsRemoteDataSourceImpl implements CovidNewsRemoteDatasource {
  CovidNewsRemoteDataSourceImpl({@required this.client});
  final http.Client client;

  @override
  Future<List<CovidNewsModel>> getGlobalCovidNews() async {
    final response = await client.get(Uri.parse(URI_FOR_GLOBAL_NEWS));
    if (response.statusCode == 200) {
      return List<CovidNewsModel>.from((json.decode(response.body) as List).map(
          (json) => CovidNewsModel.fromJson(json as Map<String, dynamic>)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CovidNewsModel>> getIndiaCovidNews() async {
    final response = await client.get(Uri.parse(URI_FOR_INDIA_NEWS));
    if (response.statusCode == 200) {
      return List<CovidNewsModel>.from((json.decode(response.body) as List).map(
          (json) => CovidNewsModel.fromJson(json as Map<String, dynamic>)));
    } else {
      throw ServerException();
    }
  }
}

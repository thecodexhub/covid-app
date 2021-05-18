import '../models/covid_news_model.dart';

abstract class CovidNewsRemoteDatasource {
  /// Calls the https://newsapi.org/v2/{endpoint} api with `top-headlines` endpoint.
  /// Parse the value into `CovidNewsModel`.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CovidNewsModel>> getGlobalCovidNews();
  /// Calls the https://newsapi.org/v2/{endpoint} api with `top-headlines` endpoint.
  /// Parse the value into `CovidNewsModel`. And the query parameter `q` is `in`.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CovidNewsModel>> getIndiaCovidNews();
}
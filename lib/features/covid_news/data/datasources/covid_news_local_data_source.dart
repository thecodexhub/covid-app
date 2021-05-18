import '../models/covid_news_model.dart';

abstract class CovidNewsLocalDataSource {
  /// Gets the cached list of [CovidNewsModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<List<CovidNewsModel>> getLastGlobalCovidNews();

  /// Gets the cached list of [CovidNewsModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<List<CovidNewsModel>> getLastIndiaCovidNews();

  Future<void> cacheGlobalCovidNews(List<CovidNewsModel> globalNewsToCache);
  Future<void> cacheIndiaCovidNews(List<CovidNewsModel> indiaNewsToCache);
}

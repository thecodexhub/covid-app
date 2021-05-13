import '../models/covid_case_model.dart';

abstract class CovidCaseLocalDataSource {
  /// Gets the cached [CovidCaseModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<CovidCaseModel> getLastGlobalCovidCase();

  /// Gets the cached list of [CovidCaseModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<List<CovidCaseModel>> getLastCountryCovidCase();

  Future<void> cacheGlobalCovidCase(CovidCaseModel globalCaseToCache);
  Future<void> cacheCountryCovidCase(List<CovidCaseModel> countryCaseToCache);
}

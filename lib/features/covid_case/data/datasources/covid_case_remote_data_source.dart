import '../models/covid_case_model.dart';

abstract class CovidCaseRemoteDataSource {
  /// Calls the https://api.covid19api.com/{endpoint} api with `summary` endpoint.
  /// Parse the value into `CovidCaseModel` from the Map having the key `Global`.
  /// 
  /// Throws a [ServerException] for all error codes.
  Future<CovidCaseModel> getGlobalCovidCase();

  /// Calls the https://api.covid19api.com/{endpoint} api with `summary` endpoint.
  /// Parse the value into List of type `CovidCaseModel` from the Map having the key `Countries`.
  /// 
  /// Throws a [ServerException] for all error codes.
  Future<List<CovidCaseModel>> getCountryCovidCase();
}

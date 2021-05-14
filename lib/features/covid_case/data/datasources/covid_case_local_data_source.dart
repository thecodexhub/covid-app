import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const CACHED_GLOBAL_COVID_CASE = 'CACHED_GLOBAL_COVID_CASE';
const CACHED_COUNTRY_COVID_CASE = 'CACHED_COUNTRY_COVID_CASE';

class CovidCaseLocalDataSourceImpl implements CovidCaseLocalDataSource {
  CovidCaseLocalDataSourceImpl({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<CovidCaseModel> getLastGlobalCovidCase() {
    final jsonString = sharedPreferences.getString(CACHED_GLOBAL_COVID_CASE);
    if (jsonString != null) {
      return Future.value(
        CovidCaseModel.fromJson(
            json.decode(jsonString) as Map<String, dynamic>),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<CovidCaseModel>> getLastCountryCovidCase() {
    final jsonString = sharedPreferences.getString(CACHED_COUNTRY_COVID_CASE);
    if (jsonString != null) {
      final countryCovidList = <CovidCaseModel>[];
      json.decode(jsonString).forEach((json) => countryCovidList
          .add(CovidCaseModel.fromJson(json as Map<String, dynamic>)));
      return Future.value(countryCovidList);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGlobalCovidCase(CovidCaseModel globalCaseToCache) async {
    await sharedPreferences.setString(
      CACHED_GLOBAL_COVID_CASE,
      json.encode(globalCaseToCache.toJson()),
    );
  }

  @override
  Future<void> cacheCountryCovidCase(
      List<CovidCaseModel> countryCaseToCache) async {
    final cacheData = <Map<String, dynamic>>[];
    countryCaseToCache.forEach((data) => cacheData.add(data.toJson()));
    await sharedPreferences.setString(
      CACHED_COUNTRY_COVID_CASE,
      json.encode(cacheData),
    );
  }
}

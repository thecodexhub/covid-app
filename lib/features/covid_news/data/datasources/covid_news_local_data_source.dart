import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const CACHED_GLOBAL_COVID_NEWS = 'CACHED_GLOBAL_COVID_NEWS';
const CACHED_INDIA_COVID_NEWS = 'CACHED_INDIA_COVID_NEWS';

class CovidNewsLocalDataSourceImpl implements CovidNewsLocalDataSource {
  CovidNewsLocalDataSourceImpl({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<List<CovidNewsModel>> getLastGlobalCovidNews() {
    final jsonString = sharedPreferences.getString(CACHED_GLOBAL_COVID_NEWS);
    if (jsonString != null) {
      final globalCovidNews = <CovidNewsModel>[];
      json.decode(jsonString).forEach((json) => globalCovidNews
          .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
      return Future.value(globalCovidNews);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<CovidNewsModel>> getLastIndiaCovidNews() {
    final jsonString = sharedPreferences.getString(CACHED_INDIA_COVID_NEWS);
    if (jsonString != null) {
      final indiaCovidNews = <CovidNewsModel>[];
      json.decode(jsonString).forEach((json) => indiaCovidNews
          .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
      return Future.value(indiaCovidNews);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGlobalCovidNews(
      List<CovidNewsModel> globalNewsToCache) async {
    final cacheData = <Map<String, dynamic>>[];
    globalNewsToCache.forEach((data) => cacheData.add(data.toJson()));
    await sharedPreferences.setString(
      CACHED_GLOBAL_COVID_NEWS,
      json.encode(cacheData),
    );
  }

  @override
  Future<void> cacheIndiaCovidNews(
      List<CovidNewsModel> indiaNewsToCache) async {
    final cacheData = <Map<String, dynamic>>[];
    indiaNewsToCache.forEach((data) => cacheData.add(data.toJson()));
    await sharedPreferences.setString(
      CACHED_INDIA_COVID_NEWS,
      json.encode(cacheData),
    );
  }
}

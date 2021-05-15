import 'dart:convert';

import 'package:covidapp/core/error/exception.dart';
import 'package:flutter/foundation.dart';

import '../models/covid_case_model.dart';
import 'package:http/http.dart' as http;

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

class CovidCaseRemoteDataSourceImpl implements CovidCaseRemoteDataSource {
  CovidCaseRemoteDataSourceImpl({@required this.client});
  final http.Client client;

  final String uri = 'https://api.covid19api.com/summary';

  @override
  Future<CovidCaseModel> getGlobalCovidCase() async {
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return CovidCaseModel.fromJson(
          json.decode(response.body)["Global"] as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CovidCaseModel>> getCountryCovidCase() async {
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return List<CovidCaseModel>.from(
          (json.decode(response.body)["Countries"] as List)
              .map((e) => CovidCaseModel.fromJson(e as Map<String, dynamic>)));
    } else {
      throw ServerException();
    }
  }
}

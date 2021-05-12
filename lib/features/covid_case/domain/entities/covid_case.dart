import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CovidCase extends Equatable {
  final String country;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final String updatedAt;

  const CovidCase({
    this.country,
    @required this.newConfirmed,
    @required this.totalConfirmed,
    @required this.newDeaths,
    @required this.totalDeaths,
    @required this.newRecovered,
    @required this.totalRecovered,
    @required this.updatedAt,
  });

  @override
  List<Object> get props => [
        country,
        newConfirmed,
        totalConfirmed,
        newDeaths,
        totalDeaths,
        newRecovered,
        totalRecovered,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

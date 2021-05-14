import 'package:covidapp/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/covid_case.dart';
import '../../domain/repositories/covid_case_repository.dart';
import '../datasources/covid_case_local_data_source.dart';
import '../datasources/covid_case_remote_data_source.dart';

class CovidCaseRepositoryImpl implements CovidCaseRepository {
  CovidCaseRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  final CovidCaseRemoteDataSource remoteDataSource;
  final CovidCaseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CovidCase>>> getCountryCovidCase() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountryCovidCase =
            await remoteDataSource.getCountryCovidCase();
        await localDataSource.cacheCountryCovidCase(remoteCountryCovidCase);
        return Right(remoteCountryCovidCase);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedCountryCovidCase =
            await localDataSource.getLastCountryCovidCase();
        return Right(cachedCountryCovidCase);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CovidCase>> getGlobalCovidCase() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGlobalCovidCase =
            await remoteDataSource.getGlobalCovidCase();
        await localDataSource.cacheGlobalCovidCase(remoteGlobalCovidCase);
        return Right(remoteGlobalCovidCase);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedGlobalCovidCase =
            await localDataSource.getLastGlobalCovidCase();
        return Right(cachedGlobalCovidCase);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/covid_news.dart';
import '../../domain/repositories/covid_news_repository.dart';
import '../datasources/covid_news_local_data_source.dart';
import '../datasources/covid_news_remote_data_source.dart';

class CovidNewsRepositoryImpl implements CovidNewsRepository {
  CovidNewsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  final CovidNewsRemoteDataSource remoteDataSource;
  final CovidNewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CovidNews>>> getGLobalCovidNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGlobalCovidNews =
            await remoteDataSource.getGlobalCovidNews();
        await localDataSource.cacheGlobalCovidNews(remoteGlobalCovidNews);
        return Right(remoteGlobalCovidNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedGlobalCovidNews =
            await localDataSource.getLastGlobalCovidNews();
        return Right(cachedGlobalCovidNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CovidNews>>> getIndiaCovidNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteIndiaCovidNews = await remoteDataSource.getIndiaCovidNews();
        await localDataSource.cacheIndiaCovidNews(remoteIndiaCovidNews);
        return Right(remoteIndiaCovidNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedIndiaCovidNews =
            await localDataSource.getLastIndiaCovidNews();
        return Right(cachedIndiaCovidNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

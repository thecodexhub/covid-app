import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/network/network_info.dart';
import 'package:covidapp/features/covid_news/data/datasources/covid_news_local_data_source.dart';
import 'package:covidapp/features/covid_news/data/datasources/covid_news_remote_data_source.dart';
import 'package:covidapp/features/covid_news/data/models/covid_news_model.dart';
import 'package:covidapp/features/covid_news/data/repositories/covid_news_repository_impl.dart';
import 'package:covidapp/features/covid_news/domain/entities/covid_news.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCovidNewsRemoteDataSource extends Mock
    implements CovidNewsRemoteDatasource {}

class MockCovidNewsLocalDataSource extends Mock
    implements CovidNewsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CovidNewsRepositoryImpl repository;
  MockCovidNewsRemoteDataSource mockCovidNewsRemoteDataSource;
  MockCovidNewsLocalDataSource mockCovidNewsLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockCovidNewsRemoteDataSource = MockCovidNewsRemoteDataSource();
    mockCovidNewsLocalDataSource = MockCovidNewsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CovidNewsRepositoryImpl(
      remoteDataSource: mockCovidNewsRemoteDataSource,
      localDataSource: mockCovidNewsLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getGlobalCovidNews', () {
    final tCovidNewsModelList = [
      CovidNewsModel(
        source: 'test',
        author: 'test',
        title: 'test',
        description: 'test',
        url: 'test',
        urlToImage: 'test',
        publishedAt: 'test',
      )
    ];
    final List<CovidNews> tCovidNewsList = tCovidNewsModelList;
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getGLobalCovidNews();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getGlobalCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        final result = await repository.getGLobalCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getGlobalCovidNews());
        expect(result, Right<Failure, List<CovidNews>>(tCovidNewsList));
      });

      test(
          'should cache the data locally when call to remote data source is successful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getGlobalCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        await repository.getGLobalCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getGlobalCovidNews());
        verify(mockCovidNewsLocalDataSource
            .cacheGlobalCovidNews(tCovidNewsModelList));
      });

      test(
          'should throw server exception when call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getGlobalCovidNews())
            .thenThrow(ServerException());
        // Act
        final result = await repository.getGLobalCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getGlobalCovidNews());
        verifyNoMoreInteractions(mockCovidNewsLocalDataSource);
        expect(result, equals(Left<Failure, List<CovidNews>>(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return the cached global news when the cached data is available',
          () async {
        // Arrange
        when(mockCovidNewsLocalDataSource.getLastGlobalCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        final result = await repository.getGLobalCovidNews();
        // Assert
        verify(mockCovidNewsLocalDataSource.getLastGlobalCovidNews());
        verifyZeroInteractions(mockCovidNewsRemoteDataSource);
        expect(result, equals(Right<Failure, List<CovidNews>>(tCovidNewsList)));
      });

      test(
          'should return Cachefailure when the global cached news is not present',
          () async {
        // Arrange
        when(mockCovidNewsLocalDataSource.getLastGlobalCovidNews())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getGLobalCovidNews();
        // Assert
        verify(mockCovidNewsLocalDataSource.getLastGlobalCovidNews());
        verifyZeroInteractions(mockCovidNewsRemoteDataSource);
        expect(result, equals(Left<Failure, List<CovidNews>>(CacheFailure())));
      });
    });
  });

  group('getIndiaCovidNews', () {
    final tCovidNewsModelList = [
      CovidNewsModel(
        source: 'test',
        author: 'test',
        title: 'test',
        description: 'test',
        url: 'test',
        urlToImage: 'test',
        publishedAt: 'test',
      )
    ];
    final List<CovidNews> tCovidNewsList = tCovidNewsModelList;
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getIndiaCovidNews();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getIndiaCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        final result = await repository.getIndiaCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getIndiaCovidNews());
        expect(result, Right<Failure, List<CovidNews>>(tCovidNewsList));
      });

      test(
          'should cache the data locally when call to remote data source is successful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getIndiaCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        await repository.getIndiaCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getIndiaCovidNews());
        verify(mockCovidNewsLocalDataSource
            .cacheIndiaCovidNews(tCovidNewsModelList));
      });

      test(
          'should throw server exception when call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockCovidNewsRemoteDataSource.getIndiaCovidNews())
            .thenThrow(ServerException());
        // Act
        final result = await repository.getIndiaCovidNews();
        // Assert
        verify(mockCovidNewsRemoteDataSource.getIndiaCovidNews());
        verifyNoMoreInteractions(mockCovidNewsLocalDataSource);
        expect(result, equals(Left<Failure, List<CovidNews>>(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return the cached india news when the cached data is available',
          () async {
        // Arrange
        when(mockCovidNewsLocalDataSource.getLastIndiaCovidNews())
            .thenAnswer((_) async => tCovidNewsModelList);
        // Act
        final result = await repository.getIndiaCovidNews();
        // Assert
        verify(mockCovidNewsLocalDataSource.getLastIndiaCovidNews());
        verifyZeroInteractions(mockCovidNewsRemoteDataSource);
        expect(result, equals(Right<Failure, List<CovidNews>>(tCovidNewsList)));
      });

      test(
          'should return Cachefailure when the india cached news is not present',
          () async {
        // Arrange
        when(mockCovidNewsLocalDataSource.getLastIndiaCovidNews())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getIndiaCovidNews();
        // Assert
        verify(mockCovidNewsLocalDataSource.getLastIndiaCovidNews());
        verifyZeroInteractions(mockCovidNewsRemoteDataSource);
        expect(result, equals(Left<Failure, List<CovidNews>>(CacheFailure())));
      });
    });
  });
}

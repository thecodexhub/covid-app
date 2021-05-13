import 'package:covidapp/core/error/exception.dart';
import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/platform/network_info.dart';
import 'package:covidapp/features/covid_case/data/datasources/covid_case_local_data_source.dart';
import 'package:covidapp/features/covid_case/data/datasources/covid_case_remote_data_source.dart';
import 'package:covidapp/features/covid_case/data/models/covid_case_model.dart';
import 'package:covidapp/features/covid_case/data/repositories/covid_case_repository_impl.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements CovidCaseRemoteDataSource {}

class MockLocalDataSource extends Mock implements CovidCaseLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CovidCaseRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CovidCaseRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
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

  group('getGlobalCovidCase', () {
    final tCovidCaseModel = CovidCaseModel(
      country: 'test',
      newConfirmed: 1,
      totalConfirmed: 1,
      newDeaths: 1,
      totalDeaths: 1,
      newRecovered: 1,
      totalRecovered: 1,
      updatedAt: 'test',
    );
    final CovidCase tCovidCase = tCovidCaseModel;
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getGlobalCovidCase();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getGlobalCovidCase())
            .thenAnswer((_) async => tCovidCaseModel);
        // Act
        final result = await repository.getGlobalCovidCase();
        // Assert
        verify(mockRemoteDataSource.getGlobalCovidCase());
        expect(result, equals(Right<Failure, CovidCase>(tCovidCase)));
      });

      test(
          'should cache the data locally when call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getGlobalCovidCase())
            .thenAnswer((_) async => tCovidCaseModel);
        // Act
        await repository.getGlobalCovidCase();
        // Assert
        verify(mockRemoteDataSource.getGlobalCovidCase());
        verify(mockLocalDataSource.cacheGlobalCovidCase(tCovidCaseModel));
      });

      test(
          'should throw server exception when call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getGlobalCovidCase())
            .thenThrow(ServerException());
        // Act
        final result = await repository.getGlobalCovidCase();
        // Assert
        verify(mockRemoteDataSource.getGlobalCovidCase());
        verifyNoMoreInteractions(mockLocalDataSource);
        expect(result, equals(Left<Failure, CovidCase>(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return the cached global data when the cached data is available',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastGlobalCovidCase())
            .thenAnswer((_) async => tCovidCaseModel);
        // Act
        final result = await repository.getGlobalCovidCase();
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastGlobalCovidCase());
        expect(result, equals(Right<Failure, CovidCase>(tCovidCase)));
      });

      test(
          'should return Cachefailure when the global cached data is not present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastGlobalCovidCase())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getGlobalCovidCase();
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastGlobalCovidCase());
        expect(result, equals(Left<Failure, CovidCase>(CacheFailure())));
      });
    });
  });

  group('getCountryCovidCase', () {
    final tCovidCaseModel = CovidCaseModel(
      country: 'test',
      newConfirmed: 1,
      totalConfirmed: 1,
      newDeaths: 1,
      totalDeaths: 1,
      newRecovered: 1,
      totalRecovered: 1,
      updatedAt: 'test',
    );
    final CovidCase tCovidCase = tCovidCaseModel;
    final tCovidCaseModelList = [tCovidCaseModel];
    final List<CovidCase> tCovidCaseList = tCovidCaseModelList;
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getCountryCovidCase();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCountryCovidCase())
            .thenAnswer((_) async => tCovidCaseModelList);
        // Act
        final result = await repository.getCountryCovidCase();
        // Assert
        verify(mockRemoteDataSource.getCountryCovidCase());
        expect(result, equals(Right<Failure, List<CovidCase>>(tCovidCaseList)));
      });

      test(
          'should cache the data locally when call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCountryCovidCase())
            .thenAnswer((_) async => tCovidCaseModelList);
        // Act
        await repository.getCountryCovidCase();
        // Assert
        verify(mockRemoteDataSource.getCountryCovidCase());
        verify(mockLocalDataSource.cacheCountryCovidCase(tCovidCaseModelList));
      });

      test(
          'should throw server exception when call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCountryCovidCase())
            .thenThrow(ServerException());
        // Act
        final result = await repository.getCountryCovidCase();
        // Assert
        verify(mockRemoteDataSource.getCountryCovidCase());
        verifyNoMoreInteractions(mockLocalDataSource);
        expect(result, equals(Left<Failure, List<CovidCase>>(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return the cached country data when the cached data is available',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastCountryCovidCase())
            .thenAnswer((_) async => tCovidCaseModelList);
        // Act
        final result = await repository.getCountryCovidCase();
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCountryCovidCase());
        expect(result, equals(Right<Failure, List<CovidCase>>(tCovidCaseList)));
      });

      test(
          'should return Cachefailure when the country cached data is not present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastCountryCovidCase())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getCountryCovidCase();
        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCountryCovidCase());
        expect(result, equals(Left<Failure, List<CovidCase>>(CacheFailure())));
      });
    });
  });
}

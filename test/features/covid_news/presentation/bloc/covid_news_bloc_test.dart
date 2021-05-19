import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_news/domain/entities/covid_news.dart';
import 'package:covidapp/features/covid_news/domain/usecases/get_global_covid_news.dart';
import 'package:covidapp/features/covid_news/domain/usecases/get_india_covid_news.dart';
import 'package:covidapp/features/covid_news/presentation/bloc/covid_news_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetGlobalCovidNews extends Mock implements GetGlobalCovidNews {}

class MockGetIndiaCovidNews extends Mock implements GetIndiaCovidNews {}

void main() {
  CovidNewsBloc bloc;
  MockGetGlobalCovidNews mockGetGlobalCovidNews;
  MockGetIndiaCovidNews mockGetIndiaCovidNews;

  setUp(() {
    mockGetGlobalCovidNews = MockGetGlobalCovidNews();
    mockGetIndiaCovidNews = MockGetIndiaCovidNews();
    bloc = CovidNewsBloc(
      global: mockGetGlobalCovidNews,
      india: mockGetIndiaCovidNews,
    );
  });

  final tCovidNews = [
    CovidNews(
      source: '',
      author: '',
      title: '',
      description: '',
      url: '',
      urlToImage: '',
      publishedAt: '',
    )
  ];

  test('Initial state should be CovidNewsInitial', () {
    // Assert
    expect(bloc.state, CovidNewsInitial());
  });

  group('GetGlobalCovidNewsEvent', () {
    test('should get data from GetGlobalCovidNews usecase', () async {
      // Arrange
      when(mockGetGlobalCovidNews(any))
          .thenAnswer((_) async => Right(tCovidNews));
      // Act
      bloc.add(GetGlobalCovidNewsEvent());
      await untilCalled(mockGetGlobalCovidNews(any));
      // Assert
      verify(mockGetGlobalCovidNews(NoParams()));
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsLoaded] when the data is gotten successfully',
        () {
      // Arrange
      when(mockGetGlobalCovidNews(any))
          .thenAnswer((_) async => Right(tCovidNews));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsLoaded(covidNews: tCovidNews),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidNewsEvent());
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsFailed] when getting data fails',
        () {
      // Arrange
      when(mockGetGlobalCovidNews(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsFailed(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidNewsEvent());
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsFailed] with a proper message of the error when getting data fails',
        () {
      // Arrange
      when(mockGetGlobalCovidNews(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsFailed(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidNewsEvent());
    });
  });

  group('GetIndiaCovidNewsEvent', () {
    test('should get data from GetIndiaCovidNews usecase', () async {
      // Arrange
      when(mockGetIndiaCovidNews(any))
          .thenAnswer((_) async => Right(tCovidNews));
      // Act
      bloc.add(GetIndiaCovidNewsEvent());
      await untilCalled(mockGetIndiaCovidNews(any));
      // Assert
      verify(mockGetIndiaCovidNews(NoParams()));
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsLoaded] when the data is gotten successfully',
        () {
      // Arrange
      when(mockGetIndiaCovidNews(any))
          .thenAnswer((_) async => Right(tCovidNews));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsLoaded(covidNews: tCovidNews),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetIndiaCovidNewsEvent());
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsFailed] when getting data fails',
        () {
      // Arrange
      when(mockGetIndiaCovidNews(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsFailed(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetIndiaCovidNewsEvent());
    });

    test(
        'should emit [CovidNewsLoading], [CovidNewsFailed] with a proper message of the error when getting data fails',
        () {
      // Arrange
      when(mockGetIndiaCovidNews(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // Assert later
      final expected = [
        CovidNewsLoading(),
        CovidNewsFailed(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetIndiaCovidNewsEvent());
    });
  });
}

import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:covidapp/features/covid_case/domain/usecases/get_global_covid_case.dart';
import 'package:covidapp/features/covid_case/presentation/bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetGlobalCovidCase extends Mock implements GetGlobalCovidCase {}

void main() {
  GlobalCovidCaseBloc bloc;
  MockGetGlobalCovidCase mockGetGlobalCovidCase;

  setUp(() {
    mockGetGlobalCovidCase = MockGetGlobalCovidCase();
    bloc = GlobalCovidCaseBloc(global: mockGetGlobalCovidCase);
  });

  final tCovidCase = CovidCase(
    country: 'test',
    newConfirmed: 1,
    totalConfirmed: 1,
    newDeaths: 1,
    totalDeaths: 1,
    newRecovered: 1,
    totalRecovered: 1,
    updatedAt: 'test',
  );

  test('initialState should be GlobalCovidCaseInitial', () {
    // Assert
    expect(bloc.state, GlobalCovidCaseInitial());
  });

  group('GetGlobalCovidCaseEvent', () {
    test('shouls get data from GetGlobalCovidCase usecase', () async {
      // Arrange
      when(mockGetGlobalCovidCase(any))
          .thenAnswer((_) async => Right(tCovidCase));
      // Act
      bloc.add(GetGlobalCovidCaseEvent());
      // untilCalled will hold the test so that the `Assert` part doesn't get
      // called before the `Act` part logic has changed something inside the bloc.
      await untilCalled(mockGetGlobalCovidCase(any));
      // Assert
      verify(mockGetGlobalCovidCase(NoParams()));
    });

    test(
        'should emit [GlobalCovidCaseLoading], [GlobalCovidCaseLoaded] when the data is gotten successfully',
        () {
      // Arrange
      when(mockGetGlobalCovidCase(any))
          .thenAnswer((_) async => Right(tCovidCase));
      // Assert later
      final expected = [
        GlobalCovidCaseLoading(),
        GlobalCovidCaseLoaded(covidCase: tCovidCase),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidCaseEvent());
    });

    test(
        'should emit [GlobalCovidCaseLoading], [GlobalCovidCaseFailed] when getting data fails',
        () {
      // Arrange
      when(mockGetGlobalCovidCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert later
      final expected = [
        GlobalCovidCaseLoading(),
        GlobalCovidCaseFailed(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidCaseEvent());
    });

    test(
        'should emit [GlobalCovidCaseLoading], [GlobalCovidCaseFailed] with a proper message of the error when getting data fails',
        () {
      // Arrange
      when(mockGetGlobalCovidCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // Assert later
      final expected = [
        GlobalCovidCaseLoading(),
        GlobalCovidCaseFailed(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetGlobalCovidCaseEvent());
    });
  });
}

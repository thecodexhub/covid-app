import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:covidapp/features/covid_case/domain/usecases/get_country_covid_case.dart';
import 'package:covidapp/features/covid_case/presentation/bloc/country_covid_case_bloc/country_covid_case_bloc.dart';
import 'package:covidapp/features/covid_case/presentation/bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetCountryCovidCase extends Mock implements GetCountryCovidCase {}

void main() {
  CountryCovidCaseBloc bloc;
  MockGetCountryCovidCase mockGetCountryCovidCase;

  setUp(() {
    mockGetCountryCovidCase = MockGetCountryCovidCase();
    bloc = CountryCovidCaseBloc(country: mockGetCountryCovidCase);
  });

  final tCovidCase = [
    CovidCase(
      country: 'test',
      newConfirmed: 1,
      totalConfirmed: 1,
      newDeaths: 1,
      totalDeaths: 1,
      newRecovered: 1,
      totalRecovered: 1,
      updatedAt: 'test',
    )
  ];

  test('Initial state should be CountryCovidCaseInitial', () {
    // Assert
    expect(bloc.state, CountryCovidCaseInitial());
  });

  group('GetCountryCovidCaseEvent', () {
    test('should get data from GetCountryCovidCase usecase', () async {
      // Arrange
      when(mockGetCountryCovidCase(any))
          .thenAnswer((_) async => Right(tCovidCase));
      // Act
      bloc.add(GetCountryCovidCaseEvent());
      // untilCalled will hold the test so that the `Assert` part doesn't get
      // called before the `Act` part logic has changed something inside the bloc.
      await untilCalled(mockGetCountryCovidCase(any));
      // Assert
      verify(mockGetCountryCovidCase(NoParams()));
    });

    test(
        'should emit [CountryCovidCaseLoading], [CountryCovidCaseLoaded] when the data is gotten successfully',
        () {
      // Arrange
      when(mockGetCountryCovidCase(any))
          .thenAnswer((_) async => Right(tCovidCase));
      // Assert later
      final expected = [
        CountryCovidCaseLoading(),
        CountryCovidCaseLoaded(covidCase: tCovidCase),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetCountryCovidCaseEvent());
    });

    test(
        'should emit [CountryCovidCaseLoading], [CountryCovidCaseFailed] when getting data fails',
        () {
      // Arrange
      when(mockGetCountryCovidCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // Assert later
      final expected = [
        CountryCovidCaseLoading(),
        CountryCovidCaseFailed(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetCountryCovidCaseEvent());
    });

    test(
        'should emit [CountryCovidCaseLoading], [CountryCovidCaseFailed] with a proper message of the error when getting data fails',
        () {
      // Arrange
      when(mockGetCountryCovidCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // Assert later
      final expected = [
        CountryCovidCaseLoading(),
        CountryCovidCaseFailed(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // Act
      bloc.add(GetCountryCovidCaseEvent());
    });
  });
}

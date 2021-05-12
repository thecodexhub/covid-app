import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:covidapp/features/covid_case/domain/repositories/covid_case_repository.dart';
import 'package:covidapp/features/covid_case/domain/usecases/get_country_covid_case.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCovidCaseRepository extends Mock implements CovidCaseRepository {}

void main() {
  GetCountryCovidCase usecase;
  MockCovidCaseRepository mockCovidCaseRepository;

  setUp(() {
    mockCovidCaseRepository = MockCovidCaseRepository();
    usecase = GetCountryCovidCase(mockCovidCaseRepository);
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

  test("should get country cases from the repository", () async {
    // Arrange
    when(mockCovidCaseRepository.getCountryCovidCase())
        .thenAnswer((_) async => Right(tCovidCase));
    // Act
    final result = await usecase(NoParams());
    // Assert
    expect(result, Right<Failure, List<CovidCase>>(tCovidCase));
    verify(mockCovidCaseRepository.getCountryCovidCase());
    verifyNoMoreInteractions(mockCovidCaseRepository);
  });
}

import 'package:covidapp/core/error/failure.dart';
import 'package:covidapp/core/usecases/usecase.dart';
import 'package:covidapp/features/covid_news/domain/entities/covid_news.dart';
import 'package:covidapp/features/covid_news/domain/repositories/covid_news_repository.dart';
import 'package:covidapp/features/covid_news/domain/usecases/get_global_covid_news.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCovidNewsRepository extends Mock implements CovidNewsRepository {}

void main() {
  GetGlobalCovidNews usecase;
  MockCovidNewsRepository mockCovidNewsRepository;

  setUp(() {
    mockCovidNewsRepository = MockCovidNewsRepository();
    usecase = GetGlobalCovidNews(mockCovidNewsRepository);
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

  test('should get global news from the repository', () async {
    // Arrange
    when(mockCovidNewsRepository.getGLobalCovidNews())
        .thenAnswer((_) async => Right(tCovidNews));
    // Act
    final result = await usecase(NoParams());
    // Assert
    expect(result, Right<Failure, List<CovidNews>>(tCovidNews));
    verify(mockCovidNewsRepository.getGLobalCovidNews());
    verifyNoMoreInteractions(mockCovidNewsRepository);
  });
}

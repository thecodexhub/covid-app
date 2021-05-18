import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/covid_news.dart';
import '../repositories/covid_news_repository.dart';

class GetGlobalCovidNews implements Usecase<List<CovidNews>, NoParams> {
  GetGlobalCovidNews(this.covidNewsRepository);
  final CovidNewsRepository covidNewsRepository;

  @override
  Future<Either<Failure, List<CovidNews>>> call(NoParams params) async {
    return await covidNewsRepository.getGLobalCovidNews();
  }
}

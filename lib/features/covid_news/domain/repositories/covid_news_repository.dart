import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/covid_news.dart';

abstract class CovidNewsRepository {
  Future<Either<Failure, List<CovidNews>>> getIndiaCovidNews();
  Future<Either<Failure, List<CovidNews>>> getGLobalCovidNews();
}

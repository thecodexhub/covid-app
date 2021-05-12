import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/covid_case.dart';

abstract class CovidCaseRepository {
  Future<Either<Failure, CovidCase>> getGlobalCovidCase();
  Future<Either<Failure, List<CovidCase>>> getCountryCovidCase();
}

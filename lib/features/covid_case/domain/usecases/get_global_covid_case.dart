import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/covid_case.dart';
import '../repositories/covid_case_repository.dart';

class GetGlobalCovidCase implements Usecase<CovidCase, NoParams> {
  GetGlobalCovidCase(this.covidCaseRepository);
  final CovidCaseRepository covidCaseRepository;

  @override
  Future<Either<Failure, CovidCase>> call(NoParams params) async {
    return await covidCaseRepository.getGlobalCovidCase();
  }
}
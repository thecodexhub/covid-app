import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/covid_case.dart';
import '../repositories/covid_case_repository.dart';

class GetCountryCovidCase implements Usecase<List<CovidCase>, NoParams> {
  GetCountryCovidCase(this.covidCaseRepository);
  final CovidCaseRepository covidCaseRepository;

  @override
  Future<Either<Failure, List<CovidCase>>> call(NoParams params) async {
    return await covidCaseRepository.getCountryCovidCase();
  }
}

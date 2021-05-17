import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/covid_case/data/datasources/covid_case_local_data_source.dart';
import 'features/covid_case/data/datasources/covid_case_remote_data_source.dart';
import 'features/covid_case/data/repositories/covid_case_repository_impl.dart';
import 'features/covid_case/domain/repositories/covid_case_repository.dart';
import 'features/covid_case/domain/usecases/get_country_covid_case.dart';
import 'features/covid_case/domain/usecases/get_global_covid_case.dart';
import 'features/covid_case/presentation/bloc/country_covid_case_bloc/country_covid_case_bloc.dart';
import 'features/covid_case/presentation/bloc/global_covid_case_bloc/global_covid_case_bloc.dart';

final g = GetIt.instance;

Future<void> init() async {
  //! Features - CovidCase
  // Register Blocs
  g.registerFactory(() => GlobalCovidCaseBloc(global: g()));
  g.registerFactory(() => CountryCovidCaseBloc(country: g()));

  // Register Usecases
  g.registerLazySingleton(() => GetGlobalCovidCase(g()));
  g.registerLazySingleton(() => GetCountryCovidCase(g()));

  // Register Repositories
  g.registerLazySingleton<CovidCaseRepository>(
    () => CovidCaseRepositoryImpl(
      remoteDataSource: g(),
      localDataSource: g(),
      networkInfo: g(),
    ),
  );

  // Register Datasources
  g.registerLazySingleton<CovidCaseRemoteDataSource>(
      () => CovidCaseRemoteDataSourceImpl(client: g()));

  g.registerLazySingleton<CovidCaseLocalDataSource>(
      () => CovidCaseLocalDataSourceImpl(sharedPreferences: g()));

  //! Core
  g.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(g()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  g.registerLazySingleton(() => sharedPreferences);
  g.registerLazySingleton(() => http.Client());
  g.registerLazySingleton(() => DataConnectionChecker());
}

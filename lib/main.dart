import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/covid_case/presentation/bloc/country_covid_case_bloc/country_covid_case_bloc.dart';
import 'features/covid_case/presentation/bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import 'features/covid_news/presentation/bloc/covid_news_bloc.dart';
import 'home_page.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalCovidCaseBloc>(
          create: (_) => di.g<GlobalCovidCaseBloc>(),
        ),
        BlocProvider<CountryCovidCaseBloc>(
          create: (_) => di.g<CountryCovidCaseBloc>(),
        ),
        BlocProvider<CovidNewsBloc>(
          create: (_) => di.g<CovidNewsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

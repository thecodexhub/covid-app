import 'package:covidapp/features/covid_case/presentation/bloc/country_covid_case_bloc/country_covid_case_bloc.dart';
import 'package:covidapp/features/covid_case/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCovidCasePage extends StatefulWidget {
  @override
  _CountryCovidCasePageState createState() => _CountryCovidCasePageState();
}

class _CountryCovidCasePageState extends State<CountryCovidCasePage> {
  @override
  void initState() {
    BlocProvider.of<CountryCovidCaseBloc>(context)
        .add(GetCountryCovidCaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16.0),
          Expanded(
            child: BlocBuilder<CountryCovidCaseBloc, CountryCovidCaseState>(
              builder: (context, state) {
                if (state is CountryCovidCaseInitial) {
                  return LoadingWidget();
                } else if (state is CountryCovidCaseLoading) {
                  return LoadingWidget();
                } else if (state is CountryCovidCaseLoaded) {
                  return CountryCovidCaseDisplay(
                      covidCaseList: state.covidCase);
                } else if (state is CountryCovidCaseFailed) {
                  return MessageDisplay(message: state.message);
                } else {
                  return LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Cases by Country',
      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18.0),
    );
  }
}

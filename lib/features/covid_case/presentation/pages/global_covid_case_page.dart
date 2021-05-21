import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import '../widgets/widgets.dart';

class GlobalCovidCasePage extends StatefulWidget {
  @override
  _GlobalCovidCasePageState createState() => _GlobalCovidCasePageState();
}

class _GlobalCovidCasePageState extends State<GlobalCovidCasePage> {
  @override
  void initState() {
    BlocProvider.of<GlobalCovidCaseBloc>(context)
        .add(GetGlobalCovidCaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16.0),
            BlocBuilder<GlobalCovidCaseBloc, GlobalCovidCaseState>(
              builder: (context, state) {
                if (state is GlobalCovidCaseInitial) {
                  return LoadingWidget();
                } else if (state is GlobalCovidCaseLoading) {
                  return LoadingWidget();
                } else if (state is GlobalCovidCaseLoaded) {
                  return GlobalCovidCaseDisplay(covidCase: state.covidCase);
                } else if (state is GlobalCovidCaseFailed) {
                  return MessageDisplay(message: state.message);
                } else {
                  return LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Coronavirus Cases',
        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18.0),
        children: <TextSpan>[
          TextSpan(
            text: ' - Worldwide',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 15.0,
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}

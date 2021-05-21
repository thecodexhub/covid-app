import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/covid_news_bloc.dart';
import '../widgets/widgets.dart';

class IndiaCovidNewsPage extends StatefulWidget {
  @override
  _IndiaCovidNewsPageState createState() => _IndiaCovidNewsPageState();
}

class _IndiaCovidNewsPageState extends State<IndiaCovidNewsPage> {
  @override
  void initState() {
    BlocProvider.of<CovidNewsBloc>(context).add(GetIndiaCovidNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CovidNewsBloc, CovidNewsState>(
      builder: (context, state) {
        if (state is CovidNewsInitial) {
          return LoadingWidget();
        } else if (state is CovidNewsLoading) {
          return LoadingWidget();
        } else if (state is CovidNewsLoaded) {
          return CovidNewsDisplay(covidNews: state.covidNews);
        } else if (state is CovidNewsFailed) {
          return MessageDisplay(message: state.message);
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

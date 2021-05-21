import 'package:flutter/material.dart';

import '../../../../core/util/number_formatter.dart';
import '../../domain/entities/covid_case.dart';

class GlobalCovidCaseDisplay extends StatelessWidget {
  const GlobalCovidCaseDisplay({Key key, @required this.covidCase})
      : super(key: key);
  final CovidCase covidCase;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Confirmed Cases'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8.0),
            Text(
              covidCase.totalConfirmed.formatNumberToString,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16.0),
            _buildCaseBlocks(
              context,
              label: 'Active Cases',
              cases: covidCase.totalConfirmed -
                  covidCase.totalRecovered -
                  covidCase.totalDeaths,
            ),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(context,
                label: 'Recovered', cases: covidCase.totalRecovered),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(context,
                label: 'Deaths', cases: covidCase.totalDeaths),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseBlocks(
    BuildContext context, {
    @required String label,
    @required int cases,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0),
        ),
        Text(
          cases.formatNumberToString,
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/util/number_formatter.dart';
import '../../domain/entities/covid_case.dart';

class GlobalCovidCaseDisplay extends StatelessWidget {
  const GlobalCovidCaseDisplay({Key key, @required this.covidCase})
      : super(key: key);
  final CovidCase covidCase;

  static const purple = Color(0xFF9B8AFF);
  static const green = Color(0xFF35D593);
  static const red = Color(0xFFEF827D);

  @override
  Widget build(BuildContext context) {
    final activeCase = covidCase.totalConfirmed -
        covidCase.totalRecovered -
        covidCase.totalDeaths;
    final activePercentage = (activeCase / covidCase.totalConfirmed) * 100;
    final recoveryPercentage =
        (covidCase.totalRecovered / covidCase.totalConfirmed) * 100;
    final deathPercentage =
        (covidCase.totalDeaths / covidCase.totalConfirmed) * 100;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                height: 6.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: activePercentage.round(),
                      child: Container(
                        color: purple,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Expanded(
                      flex: recoveryPercentage.round(),
                      child: Container(
                        color: green,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Expanded(
                      flex: deathPercentage.round(),
                      child: Container(
                        color: red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildCaseBlocks(
              context,
              color: purple,
              label: 'Active Cases',
              cases: activeCase,
              newCases: covidCase.newConfirmed,
            ),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(
              context,
              color: green,
              label: 'Recovered',
              cases: covidCase.totalRecovered,
              newCases: covidCase.newRecovered,
            ),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(
              context,
              color: red,
              label: 'Deaths',
              cases: covidCase.totalDeaths,
              newCases: covidCase.newDeaths,
            ),
            const SizedBox(height: 20.0),
            Text.rich(
              TextSpan(
                text: 'The ratio of ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'Recovery (${recoveryPercentage.toStringAsFixed(1)}%)',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 15, color: Colors.blue.shade700),
                  ),
                  TextSpan(text: ' & '),
                  TextSpan(
                    text: 'Deaths (${deathPercentage.toStringAsFixed(1)}%)',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 15, color: Colors.blue.shade700),
                  ),
                  TextSpan(text: ' globally.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseBlocks(
    BuildContext context, {
    @required Color color,
    @required String label,
    @required int cases,
    @required int newCases,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '+' + newCases.formatNumberToString,
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0),
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 12.5,
                  width: 12.5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 16.0),
                ),
              ],
            ),
            Text(
              cases.formatNumberToString,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 17.0),
            ),
          ],
        ),
      ],
    );
  }
}

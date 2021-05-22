import 'package:flutter/material.dart';

import '../../../../core/util/number_formatter.dart';
import '../../domain/entities/covid_case.dart';

class GlobalCovidCaseDisplay extends StatefulWidget {
  const GlobalCovidCaseDisplay({Key key, @required this.covidCase})
      : super(key: key);
  final CovidCase covidCase;

  static const purple = Color(0xFF9B8AFF);
  static const green = Color(0xFF35D593);
  static const red = Color(0xFFEF827D);

  @override
  _GlobalCovidCaseDisplayState createState() => _GlobalCovidCaseDisplayState();
}

class _GlobalCovidCaseDisplayState extends State<GlobalCovidCaseDisplay> {
  int activeCase;
  num activePercentage;
  num recoveryPercentage;
  num deathPercentage;

  @override
  void initState() {
    super.initState();
    activeCase = widget.covidCase.totalConfirmed -
        widget.covidCase.totalRecovered -
        widget.covidCase.totalDeaths;
    activePercentage = ((activeCase / widget.covidCase.totalConfirmed) * 100);
    recoveryPercentage =
        (widget.covidCase.totalRecovered / widget.covidCase.totalConfirmed) *
            100;
    deathPercentage =
        (widget.covidCase.totalDeaths / widget.covidCase.totalConfirmed) * 100;
  }

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
              widget.covidCase.totalConfirmed.formatNumberToString,
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
                        color: GlobalCovidCaseDisplay.purple,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Expanded(
                      flex: recoveryPercentage.round(),
                      child: Container(
                        color: GlobalCovidCaseDisplay.green,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Expanded(
                      flex: deathPercentage.round(),
                      child: Container(
                        color: GlobalCovidCaseDisplay.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildCaseBlocks(
              context,
              color: GlobalCovidCaseDisplay.purple,
              label: 'Active Cases',
              cases: activeCase,
              newCases: widget.covidCase.newConfirmed,
            ),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(
              context,
              color: GlobalCovidCaseDisplay.green,
              label: 'Recovered',
              cases: widget.covidCase.totalRecovered,
              newCases: widget.covidCase.newRecovered,
            ),
            const SizedBox(height: 8.0),
            _buildCaseBlocks(
              context,
              color: GlobalCovidCaseDisplay.red,
              label: 'Deaths',
              cases: widget.covidCase.totalDeaths,
              newCases: widget.covidCase.newDeaths,
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
            const SizedBox(height: 20.0),
            Text('Last updated on ' + widget.covidCase.updatedAt.substring(0, 10) +
                ' at ' +
                widget.covidCase.updatedAt.substring(11, 16))
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

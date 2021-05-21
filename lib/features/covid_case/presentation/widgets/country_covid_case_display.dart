import 'package:covidapp/core/util/number_formatter.dart';
import 'package:covidapp/features/covid_case/domain/entities/covid_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryCovidCaseDisplay extends StatefulWidget {
  const CountryCovidCaseDisplay({Key key, @required this.covidCaseList})
      : super(key: key);
  final List<CovidCase> covidCaseList;

  static const purple = Color(0xFF9B8AFF);
  static const green = Color(0xFF35D593);
  static const red = Color(0xFFEF827D);

  @override
  _CountryCovidCaseDisplayState createState() =>
      _CountryCovidCaseDisplayState();
}

class _CountryCovidCaseDisplayState extends State<CountryCovidCaseDisplay> {
  int segmentedControlGroupValue = 0;

  @override
  void initState() {
    widget.covidCaseList
        .sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CupertinoSegmentedControl<int>(
            onValueChanged: (val) => setState(() {
              segmentedControlGroupValue = val;
              switch (val) {
                case 0:
                  widget.covidCaseList.sort(
                      (a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
                  return null;
                  break;
                case 1:
                  widget.covidCaseList.sort(
                      (a, b) => b.totalRecovered.compareTo(a.totalRecovered));
                  return null;
                  break;
                case 2:
                  widget.covidCaseList
                      .sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));
                  return null;
                  break;
              }
            }),
            groupValue: segmentedControlGroupValue,
            padding: EdgeInsets.all(4.0),
            selectedColor: getSelectedColor(segmentedControlGroupValue),
            borderColor: getSelectedColor(segmentedControlGroupValue),
            children: <int, Widget>{
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Active'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Recovered'),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text('Deaths'),
              ),
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.separated(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.covidCaseList.length,
                itemBuilder: (context, index) {
                  final country = widget.covidCaseList[index];
                  return _buildListContent(
                      country, context, segmentedControlGroupValue);
                },
                separatorBuilder: (context, index) => Divider(thickness: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListContent(CovidCase country, BuildContext context, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              country.country,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '+' + getNewCase(value, country),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 13.0, color: Colors.grey.shade700),
                ),
                const SizedBox(width: 8.0),
                Text(
                  getTotalCase(value, country),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 17.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTotalCase(int index, CovidCase country) {
    switch (index) {
      case 0:
        return country.totalConfirmed.formatNumberToString;
        break;
      case 1:
        return country.totalRecovered.formatNumberToString;
        break;
      case 2:
        return country.totalDeaths.formatNumberToString;
        break;
      default:
        return country.totalConfirmed.formatNumberToString;
    }
  }

  String getNewCase(int index, CovidCase country) {
    switch (index) {
      case 0:
        return country.newConfirmed.formatNumberToString;
        break;
      case 1:
        return country.newRecovered.formatNumberToString;
        break;
      case 2:
        return country.newDeaths.formatNumberToString;
        break;
      default:
        return country.newConfirmed.formatNumberToString;
    }
  }

  Color getSelectedColor(int index) {
    switch (index) {
      case 0:
        return CountryCovidCaseDisplay.purple;
        break;
      case 1:
        return CountryCovidCaseDisplay.green;
        break;
      case 2:
        return CountryCovidCaseDisplay.red;
        break;
      default:
        return CountryCovidCaseDisplay.purple;
    }
  }
}

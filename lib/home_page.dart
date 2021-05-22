import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';
import 'features/covid_case/presentation/pages/country_covid_case_page.dart';
import 'features/covid_case/presentation/pages/global_covid_case_page.dart';
import 'features/covid_news/presentation/pages/global_covid_news_page.dart';
import 'features/covid_news/presentation/pages/india_covid_news_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          selectedIndex == 0
              ? AppLocalizations.of(context).translate('covidCasesAppBarTitle')
              : AppLocalizations.of(context).translate('covidNewsAppBarTitle'),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.topCenter,
            child: CupertinoSlidingSegmentedControl<int>(
              onValueChanged: (val) =>
                  setState(() => segmentedControlGroupValue = val),
              groupValue: segmentedControlGroupValue,
              padding: EdgeInsets.all(4.0),
              children: <int, Widget>{
                0: Text(
                  selectedIndex == 0
                      ? AppLocalizations.of(context)
                          .translate('covidCasesWorldwideTitle')
                      : AppLocalizations.of(context)
                          .translate('covidNewsWorldwideTitle'),
                ),
                1: Text(
                  selectedIndex == 0
                      ? AppLocalizations.of(context)
                          .translate('covidCasesCountryTitle')
                      : AppLocalizations.of(context)
                          .translate('covidNewsIndiaTitle'),
                )
              },
            ),
          ),
          Expanded(
            child: selectedIndex == 0
                ? segmentedControlGroupValue == 0
                    ? GlobalCovidCasePage()
                    : CountryCovidCasePage()
                : segmentedControlGroupValue == 0
                    ? GlobalCovidNewsPage()
                    : IndiaCovidNewsPage(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) => setState(
          () {
            selectedIndex = val;
            segmentedControlGroupValue = 0;
          },
        ),
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contactless_outlined),
            label: AppLocalizations.of(context).translate('bottomBarCaseTitle'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            label: AppLocalizations.of(context).translate('bottomBarNewsTitle'),
          ),
        ],
      ),
    );
  }
}

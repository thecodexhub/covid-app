import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app_localizations.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 6,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(AppLocalizations.of(context).translate('loadingMessage')),
            const SizedBox(height: 12.0),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}

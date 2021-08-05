import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:bcm_alpha_app/screens/shareholder_packages_screen.dart';
import 'package:flutter/material.dart';

import 'my_contracts.dart';

class ContractsOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                Navigator.of(context).pushNamed(InvestmentsScreen.routeName);
              },
              child: ListTile(
                  title: Text('New Investor Contract',
                      style: Theme.of(context).textTheme.headline5),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: Colors.white))),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ShareholderPackagesScreen.routeName);
              },
              child: ListTile(
                  title: Text('New Shareholder Contract',
                      style: Theme.of(context).textTheme.headline5),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: Colors.white))),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                Navigator.of(context).pushNamed(Contracts.routeName);
              },
              child: ListTile(
                  title: Text('My Contracts',
                      style: Theme.of(context).textTheme.headline5),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: Colors.white))),
        ),
      ],
    );
  }
}

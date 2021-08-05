import 'package:bcm_alpha_app/screens/shareholder_packages_screen.dart';
import 'package:flutter/material.dart';

class ActiveContractsItems extends StatelessWidget {
  final dynamic activeContractData;

  const ActiveContractsItems({Key ? key, required this.activeContractData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Active Contracts',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ))
                    ],
                  )),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ShareholderPackagesScreen.routeName);
                    },
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Shareholder Contracts'),
                          Text('${03}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Investor Contracts'),
                          Text('${0.00}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Monthly Return'),
                          Text('${0.00}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Percentage'),
                          Text(
                              '0%',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Total Investments'),
                          Text('${0.00}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(''),
                          Text('',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

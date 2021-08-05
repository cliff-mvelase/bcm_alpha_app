import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:flutter/material.dart';

class InvestmentContract extends StatelessWidget {
  final dynamic investmentData;

  const InvestmentContract({Key ? key, @required this.investmentData})
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
                              'Investment Contracts',
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
                          .pushNamed(InvestmentsScreen.routeName);
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Capital Invested'),
                          Text('\$ ${investmentData["total_investment_usd"]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Bitcoin Value'),
                          Text('${investmentData["total_investment_btc"]} BTC',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Monthly Return'),
                          Text('\$ ${investmentData["monthly_return"]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Contracts'),
                          Text(
                              '${investmentData["contracts"]["number_of_contracts"]}',
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

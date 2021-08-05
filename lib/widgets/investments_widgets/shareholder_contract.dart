import 'package:bcm_alpha_app/screens/shareholder_packages_screen.dart';
import 'package:flutter/material.dart';

class ShareHolderContracts extends StatelessWidget {
  final dynamic shareholderData;

  const ShareHolderContracts({Key? key, @required this.shareholderData})
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
                              'Shareholder Contracts',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Capital Invested'),
                          Text('\$ ${shareholderData["capital_invested_usd"]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Bitcoin Value'),
                          Text('${shareholderData["capital_invested_btc"]} BTC',
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
                          Text('Ordinary Shares'),
                          Text('${shareholderData["number_of_shares"]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Contracts'),
                          Text(
                              '${shareholderData["contracts"]["number_of_contracts"]}',
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
                          Text('Monthly Returns'),
                          Text('0.00',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Bitcoin Value'),
                          Text('0.00 BTC',
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

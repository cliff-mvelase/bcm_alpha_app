import 'package:bcm_alpha_app/screens/transaction_history.dart';
import 'package:bcm_alpha_app/screens/transfer_tabs.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';
import 'package:flutter/material.dart';

class WalletItem extends StatefulWidget {
  final dynamic walletData;

  WalletItem({Key ? key, required this.walletData}) : super(key: key);

  @override
  _WalletItemState createState() => _WalletItemState();
}

class _WalletItemState extends State<WalletItem> {
  bool _obscureText = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
                              'Wallet',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )),

                    ],
                  )),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                            color: Colors.white,
                            onPressed: () {
                              _toggle();
                            },
                          ))
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(TransactionHistory.routeName);
                    },
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Image.asset("assets/images/bitcoin.png",
                                width: 20, height: 20),
                            SizedBox(width: 10),
                            Text(
                                _obscureText
                                    ? "******"
                                    : '${widget.walletData["BTC"]["BTC"]} BTC',
                                style: TextStyle(color: Colors.white)),
                          ]),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Image.asset("assets/images/USDT.png",
                                width: 20, height: 20),
                            SizedBox(width: 10),
                            Text(
                                _obscureText
                                    ? "******"
                                    : '${widget.walletData["USDT"]["USDT"]} USDT',
                                style: TextStyle(color: Colors.white))
                          ]),
                        ],
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Image.asset("assets/images/etherium.png",
                                width: 20, height: 20),
                            SizedBox(width: 10),
                            Text(
                                _obscureText
                                    ? "******"
                                    : '${widget.walletData["ETH"]["ETH"]} ETH',
                                style: TextStyle(color: Colors.white)),
                          ]),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Image.asset("assets/images/USSD.png",
                                width: 20, height: 20),
                            SizedBox(width: 66),
                            Text(
                                _obscureText
                                    ? "******"
                                    : '${widget.walletData["USDD"]["USDD"]} USDD',
                                style: TextStyle(color: Colors.white))
                          ]),
                        ],
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              _obscureText
                                  ? "******"
                                  : '\$ ${widget.walletData["total"]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text('Wallet Balance'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                              _obscureText
                                  ? "******"
                                  : '${widget.walletData["total_btc"]} BTC',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text('Wallet Balance BTC'),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // FlatButton(
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed(TransactionsTabs.routeName);
                    //   },
                    //   child: Text('Deposit',
                    //       style: Theme.of(context).textTheme.headline5),
                    // ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WithdrawalsTabs.routeName);
                      },
                      child: Text('Withdraw',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(TransferTabs.routeName);
                      },
                      child: Text('Transfer',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

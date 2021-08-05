import 'dart:convert';
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class WithdrawBitcoinScreen extends StatefulWidget {
  @override
  _WithdrawBitcoinScreenState createState() => _WithdrawBitcoinScreenState();
}

class _WithdrawBitcoinScreenState extends State<WithdrawBitcoinScreen> {
  bool isLoading = false;
  var amountBtcController = TextEditingController();
  var amountFiatController = TextEditingController();
  var bitcoinAddressController = TextEditingController();
  var _value = false;

  @override
  Widget build(BuildContext context) {
    Future<void> withdrawBitcoin() async {
      setState(() {
        isLoading = true;
      });
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      var token = sharedPrefs.getString("token") ?? null;

      var response = await http.post(
        Uri.parse(ApiProvider.api + 'withdrawal'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode(<String, String>{
          'amount_btc': amountBtcController.text,
          'amount_fiat': amountFiatController.text,
          'type': 'btc',
          'bitcoin_address': bitcoinAddressController.text,
          'agreeTerms': _value ? '1' : '0'
        }),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["data"]["status"] == "success") {
        setState(() {
          isLoading = false;
          sharedPrefs.setString("token", jsonResponse["data"]["token"]);
          showAlertDialog(jsonResponse["data"]["message"]);
        });
      } else {
        Toast.show("Something went wrong. Please try again", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }

    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Amount USD',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'USD',
                      ),
                      controller: amountFiatController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Amount BTC',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'BTC',
                      ),
                      controller: amountBtcController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Bitcoin address',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextField(
                      decoration: InputDecoration(),
                      controller: bitcoinAddressController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Transaction Terms: Transactions approval may take up to 2 working Days. During this time reconciliations are done to safe complete your request, kindly be patient.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: _value,
                              onChanged: (bool ? newValue )=> {
                                setState(() {
                                  _value = newValue as bool;
                                })
                              },
                            ),
                            Expanded(
                                child: Text(
                              "I have read and and agree with the transaction terms!.",
                              style: Theme.of(context).textTheme.headline6,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          //height: 100,
                          child: FlatButton(
                            onPressed: () {
                              if (amountBtcController == null ||
                                  amountFiatController == null ||
                                  bitcoinAddressController == null) {
                                Toast.show(
                                    "Please provide all the details", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else {
                                withdrawBitcoin();
                              }
                            },
                            child: Text(
                              'Submit',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            content: Text(message,
                style: TextStyle(color: Colors.black, fontSize: 16)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //  Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  Navigator.of(context).pushNamed(WithdrawalsTabs.routeName);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }
}

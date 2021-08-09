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

    void _convertUsdToBtc(String? text) async {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      var token = sharedPrefs.getString("token") ?? null;

      if (amountFiatController.text != null ) {
        var response = await http.post(
          Uri.parse(ApiProvider.api + 'covertusdtobtc'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            'amount_usd': amountFiatController.text,
          }),
        );

        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["data"]["status"] == "success") {
          setState(() {
            isLoading = true;
            amountBtcController.text = jsonResponse["data"]["data"].toString();
          });
        } else {
          Toast.show("Something went wrong. Please try again", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }
    }

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
          padding: EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 10.0),
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Text(
                      'USD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: ' amount',
                        hintStyle: TextStyle(color: Colors.white60, fontSize: 15.0, fontWeight: FontWeight.w100),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: amountFiatController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'BTC',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: ' value',
                        hintStyle: TextStyle(color: Colors.white60, fontSize: 15.0, fontWeight: FontWeight.w100),
                      ),
                      controller: amountBtcController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'BITCOIN ADDRESS',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(),
                      controller: bitcoinAddressController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Transaction Terms:  Transactions approval may take up to 2 working Days. During this time reconciliations are done to safe complete your request, kindly be patient.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
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
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                            child:  Expanded(
                              child: Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                  margin: EdgeInsets.all(30.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: Colors.white, width: 1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: (){
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
                                        child: Text("SUBMIT",
                                            style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  )),
                            )
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
              TextButton(
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

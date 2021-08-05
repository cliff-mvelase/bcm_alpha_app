import 'dart:convert';
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/transfer_tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class TransferFundsScreen extends StatefulWidget {
  @override
  _TransferFundsScreenState createState() => _TransferFundsScreenState();
}

class _TransferFundsScreenState extends State<TransferFundsScreen> {
  bool isLoading = false;
  var amountBtcController = TextEditingController();
  var amountUsdController = TextEditingController();
  var recipientEmailController = TextEditingController();

  Future<void> transfer() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;

    var response = await http.post(
      Uri.parse(ApiProvider.api + 'transfer'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'amount_btc': amountBtcController.text,
        'amount_usd': amountUsdController.text,
        'recipient_email': recipientEmailController.text,
      }),
    );

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        isLoading = false;
        sharedPrefs.setString("token", jsonResponse["data"]["token"]);
        Navigator.of(context).pushNamed(TransferTabs.routeName);
      });
    } else {
      Toast.show("Something went wrong. Please try again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      'Send funds to recipient registered on the system',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Amount USD',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'USD',
                      ),
                      controller: amountUsdController,
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
                      'Recipient Address',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextField(
                      decoration: InputDecoration(),
                      keyboardType: TextInputType.emailAddress,
                      controller: recipientEmailController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          //height: 100,
                          child: FlatButton(
                            onPressed: () {
                              if (amountBtcController == null ||
                                  amountUsdController == null ||
                                  recipientEmailController == null) {
                                Toast.show(
                                    "Please provide all the details", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else {
                                transfer();
                                Toast.show(
                                    "Transfer successfully completed", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
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
}

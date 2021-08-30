import 'dart:convert';
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/transfer_tabs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
      Fluttertoast.showToast(
        msg: "Something went wrong!!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 10.0),
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Text(
                      'Send funds to recipient registered on the system',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'USD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'amount',
                        hintStyle: TextStyle(color: Colors.white60, fontSize: 15.0, fontWeight: FontWeight.w100),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: amountUsdController,
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
                      decoration: InputDecoration(
                        hintText: ' 0x0...',
                        hintStyle: TextStyle(color: Colors.white60, fontSize: 15.0, fontWeight: FontWeight.w100),
                      ),
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
                                      if (amountBtcController == null || amountUsdController == null || recipientEmailController == null)
                                      {
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong!!!",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                      }
                                      else
                                        {
                                        transfer();
                                        Fluttertoast.showToast(
                                            msg: "Transfer Successful",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                        }
                                    },
                                    child: Text("SEND",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              )),
                        )
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     SizedBox(
                    //       height: 30,
                    //     ),
                    //     Container(
                    //       alignment: Alignment.center,
                    //       //height: 100,
                    //       child: FlatButton(
                    //         onPressed: () {
                    //           if (amountBtcController == null ||
                    //               amountUsdController == null ||
                    //               recipientEmailController == null) {
                    //             Toast.show(
                    //                 "Please provide all the details", context,
                    //                 duration: Toast.LENGTH_LONG,
                    //                 gravity: Toast.BOTTOM);
                    //           } else {
                    //             transfer();
                    //             Toast.show(
                    //                 "Transfer successfully completed", context,
                    //                 duration: Toast.LENGTH_LONG,
                    //                 gravity: Toast.BOTTOM);
                    //           }
                    //         },
                    //         child: Text(
                    //           'Submit',
                    //           style: Theme.of(context).textTheme.headline6,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

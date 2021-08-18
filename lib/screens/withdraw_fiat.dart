import 'dart:convert';
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class WithdrawalFiatScreen extends StatefulWidget {
  @override
  _WithdrawalFiatScreenState createState() => _WithdrawalFiatScreenState();
}

class _WithdrawalFiatScreenState extends State<WithdrawalFiatScreen> {
  bool isLoading = false;
  var amountBtcController = TextEditingController();
  var amountFiatController = TextEditingController();
  var withdrawalTypeController = TextEditingController();
  var countryController = TextEditingController();
  var emailAddressController = TextEditingController();
  var cellNumberController = TextEditingController();
  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var swiftCodeController = TextEditingController();
  var sortCodeController = TextEditingController();
  var agreeTermController = TextEditingController();

  //Load dropdown boxes
   late List  countryList;
   var  _country;
   var _withdrawalType;
   late List withdrawalTypeList;

  //Hiding and showing widgets depending on select withdraw type
  var showBankWidget = false;
  var showPayWidget = false;
  var showOtherWidget = false;
  var _checkboxValue = false;

  @override
  void initState() {
    super.initState();
    _loadWithdrawalType();
  }

  Future<void> _loadWithdrawalType() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token");
    var response = await http.get(
      Uri.parse(ApiProvider.api + 'withdrawalservices'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(()  {
         isLoading = true;
        withdrawalTypeList =  jsonResponse["data"]["withdrawtype"];
       countryList = jsonResponse["data"]["countries"];
      });
    } else {
      Toast.show("Something went wrong. Please try again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> _withdrawBitcoin() async {
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
        'amount_fiat': amountFiatController.text,
        'type': 'fiat',
        'withdrawal_type': _withdrawalType,
        'email': emailAddressController.text,
        'cell_number': cellNumberController.text,
        'bank_name': bankNameController.text,
        'account_number': accountNumberController.text,
        'swift_code': swiftCodeController.text,
        'sort_code': sortCodeController.text,
        'agreeTerms': _checkboxValue ? '1' : '0'
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 10.0),
          child: Container(
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                      controller: amountFiatController,
                      onChanged: (text) {
                        _convertUsdToBtc(text);
                      },
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
                        hintText: ' amount',
                        hintStyle: TextStyle(color: Colors.white60, fontSize: 15.0, fontWeight: FontWeight.w100),
                      ),
                      controller: amountBtcController,
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Withdrawal Type',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _withdrawalType,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                      ),
                                      hint: Text(
                                          'Select withdrawal type',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white70),),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _withdrawalType = newValue as String;
                                          print(_withdrawalType);
                                          if (_withdrawalType ==
                                              'bank-transfer') {
                                            showBankWidget = true;
                                            showOtherWidget = false;
                                            showPayWidget = false;
                                          } else if (_withdrawalType ==
                                              'paypal') {
                                            showBankWidget = false;
                                            showOtherWidget = false;
                                            showPayWidget = true;
                                          } else {
                                            showOtherWidget = true;
                                            showPayWidget = false;
                                            showBankWidget = false;
                                          }
                                        });
                                      },
                                      items : withdrawalTypeList.map((item) {
                                            return new DropdownMenuItem(
                                              child: new Text(item),
                                              value: item.toString(),
                                            );
                                          }).toList()
                                          ,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Country',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _country,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                      ),
                                      hint: Text(
                                          'Select country',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white70),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _country = newValue as String;
                                          print(_country);
                                        });
                                      },
                                      items: countryList.map((item) {
                                            return new DropdownMenuItem(
                                              child: new Text(item['name']),
                                              value: item['name'].toString(),
                                            );
                                          }).toList()
                                          ,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    // Visibility(
                    //     child: Text(
                    //       'Bank name',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //         hintText: 'Bank name',
                    //       ),
                    //       onSubmitted: (_) => null,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: Text(
                    //       'Account number',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //         hintText: 'Account number',
                    //       ),
                    //       controller: accountNumberController,
                    //       onSubmitted: (_) => null,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: Text(
                    //       'Swift Code',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //         hintText: 'Swift Code',
                    //       ),
                    //       controller: swiftCodeController,
                    //       onSubmitted: (_) => null,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: Text(
                    //       'Sort Code',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //         hintText: 'Sort Code',
                    //       ),
                    //       controller: sortCodeController,
                    //       onSubmitted: (_) => null,
                    //     ),
                    //     visible: showBankWidget),
                    // Visibility(
                    //     child: Text(
                    //       'Email address',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showPayWidget),
                    // Visibility(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       hintText: 'email@provider.co.za',
                    //     ),
                    //     controller: emailAddressController,
                    //     onSubmitted: (_) => null,
                    //   ),
                    //   visible: showPayWidget,
                    // ),
                    // Visibility(
                    //     child: Text(
                    //       'Cell number',
                    //       style: Theme.of(context).textTheme.headline5,
                    //     ),
                    //     visible: showOtherWidget),
                    // Visibility(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       hintText: '+27',
                    //     ),
                    //     controller: cellNumberController,
                    //     onSubmitted: (_) => null,
                    //   ),
                    //   visible: showOtherWidget,
                    // ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Transaction Terms:  Transactions approval may take up to 2 working Days. During this time reconciliations are done to safe complete your request, kindly be patient.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: _checkboxValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _checkboxValue = newValue as bool;
                                });
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
                                          _withdrawBitcoin();
                                        },
                                        child: Text("SUBMIT",
                                            style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  )),
                            )
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   //height: 100,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       _withdrawBitcoin();
                        //     },
                        //     child: Text(
                        //       'Submit',
                        //       style: Theme.of(context).textTheme.headline6,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
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

import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/widgets/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistory extends StatefulWidget {
  static const routeName = '/transactionHistory';

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
 late List<dynamic> transactions;
  bool isLoading = false;

  Future<void> getTransactionData() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
        Uri.parse(ApiProvider.api + 'wallet'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        transactions = jsonResponse["data"]["data"]["transaction_data"]["data"];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getTransactionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/LogoSolid.png',
              fit: BoxFit.cover, height: 50),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    'Payout History',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TransactionHistoryWidget(transactions: transactions)
                ],
              ));
  }
}

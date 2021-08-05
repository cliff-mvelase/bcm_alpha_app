import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/widgets/withdrawals_widgets/withdrawal_history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalViewPendingReqstScreen extends StatefulWidget {
  static const routeName = '/withdrawalViewPending';

  @override
  _WithdrawalViewPendingReqstScreenState createState() =>
      _WithdrawalViewPendingReqstScreenState();
}

class _WithdrawalViewPendingReqstScreenState
    extends State<WithdrawalViewPendingReqstScreen> {
  late List<dynamic> withdrawals;
  bool isLoading = false;

  Future<void> getWithdrawalData() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response =
        await http.get(
            Uri.parse(ApiProvider.api + 'withdrawalsview'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        withdrawals = jsonResponse["data"]["data"];
        if (withdrawals.isNotEmpty) {
          withdrawals = withdrawals
              .where((withdrawal) => withdrawal['status'] == 'pending')
              .toList();
        }
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getWithdrawalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  WithdrawalHistoryWidget(withdrawals: withdrawals)
                ],
              ));
  }
}

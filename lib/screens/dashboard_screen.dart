import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/dividends_screen.dart';
import 'package:bcm_alpha_app/screens/latest_payouts_screen.dart';
import 'package:bcm_alpha_app/screens/reports_screens.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_tabs.dart';
import 'package:bcm_alpha_app/widgets/active_contracts_items.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/investment_contract.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/shareholder_contract.dart';
import 'package:bcm_alpha_app/widgets/wallet_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  dynamic walletData;
  dynamic shareholderData;
  dynamic investmentData;
  bool isLoading = false;

  Future<void> getDashboardData() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
        Uri.parse(ApiProvider.api + 'dashboard_data'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        walletData = jsonResponse["data"]["data"]["wallet"];
        shareholderData =
            jsonResponse["data"]["data"]["contracts"]["shareholder"];
        investmentData =
            jsonResponse["data"]["data"]["contracts"]["investment"];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView(
            children: <Widget>[
              WalletItem(walletData: walletData),
              shareholderData == null ? Container() : ShareHolderContracts(shareholderData: shareholderData),
              investmentData == null ? Container() : InvestmentContract(investmentData: investmentData),
              ActiveContractsItems(activeContractData: null,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WithdrawalsViewTabs.routeName);
                      },
                      child: ListTile(
                          title: Text('Withdrawal Request',
                              style: Theme.of(context).textTheme.headline5),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.white))),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(LatestPayoutsScreen.routeName);
                      },
                      child: ListTile(
                          title: Text('Latest Payouts',
                              style: Theme.of(context).textTheme.headline5),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.white))),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(DividendsScreen.routeName);
                      },
                      child: ListTile(
                          title: Text('Dividends',
                              style: Theme.of(context).textTheme.headline5),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.white))),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ReportsScreen.routeName);
                      },
                      child: ListTile(
                          title: Text('Reports',
                              style: Theme.of(context).textTheme.headline5),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.white))),
                ),
              ),
            ],
          );
  }
}

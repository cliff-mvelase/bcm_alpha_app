import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';

import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/investment_contract.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PackagesTabs extends StatefulWidget {
  static const routeName = 'PackagesTabs';
  @override
  _PackagesTabsState createState() => _PackagesTabsState();
}

class _PackagesTabsState extends State<PackagesTabs> with SingleTickerProviderStateMixin
{
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
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: LightColor.navyBlue1,
            bottom: const TabBar(
              tabs: [
                Tab( child: TitleText(text: "Investment Packages", color: Colors.white70,), ),
              ],
            ),
            title: const Text('Withdrawals'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align (
                  alignment: Alignment.topCenter,
                  child: TabBarView(
                    children: [
                     InvestmentContract(investmentData: investmentData)

                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
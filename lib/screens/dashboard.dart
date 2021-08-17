import 'dart:async';
import 'dart:io';

import 'package:bcm_alpha_app/screens/contracts_tabs.dart';
import 'package:bcm_alpha_app/screens/packages_tabs.dart';
import 'package:bcm_alpha_app/screens/payments_tabs.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bcm_alpha_app/screens/balance_card.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:bcm_alpha_app/network/api_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

  Widget _appBar() {
    return Row(
      children: <Widget>[
        SizedBox(width: 15),
        TitleText(text: "Hello,"),
        Text(' User,',
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: LightColor.navyBlue2)),
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(ContractsTabs.routeName);
            },
            child: _icon(Icons.share, "Contracts", ContractsTabs.routeName )),
        GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(WithdrawalsTabs.routeName);
            },
            child: _icon(Icons.inventory, "Widthwals", WithdrawalsTabs.routeName)),
        GestureDetector(
            onTap:() {
              Navigator.of(context).pushNamed(PaymentsTabs.routeName);
            },
            child: _icon(Icons.payment, "Payments", PaymentsTabs.routeName)),
        GestureDetector(
            onTap:(){
              Navigator.of(context).pushNamed(PackagesTabs.routeName);
            },
            child: _icon(Icons.people, "Packages", PackagesTabs.routeName)),
      ],
    );
  }

  Widget _icon(IconData icon, String text, routeName) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(routeName);
          },
          child: Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(icon),
          ),
        ),
        Text(text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff76797e))),
      ],
    );
  }

  Widget _walletList() {
    return Column(
      children: <Widget> [
        _transaction("BTC", "23 Feb 2021",  '${walletData["BTC"]["BTC"]}' ),
        _transaction("ETH", "25 Feb 2021", '${walletData["ETH"]["ETH"]}'),
        _transaction("USDT", "03 Mar 2021", '${walletData["USDT"]["USDT"]}'),
      ],
    );
  }

  Widget _transaction(String text, String time, walletData) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: LightColor.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(walletData,
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.navyBlue2))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      _appBar(),
                      SizedBox(
                        height: 20,
                      ),
                      BalanceCard(walletData: walletData ),
                      SizedBox(
                        height: 15,
                      ),
                      TitleText(
                        text: "Operations",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _operationsWidget(),
                      SizedBox(
                        height: 30,
                      ),
                      TitleText(
                        text: "Wallet Balance Accounts",
                      ),
                      _walletList(),
                    ],
                  )),
            )));
  }

}

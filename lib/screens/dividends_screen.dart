import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/widgets/dividends_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DividendsScreen extends StatefulWidget {
  static const routeName = '/dividends';

  @override
  _DividendsScreenState createState() => _DividendsScreenState();
}

class _DividendsScreenState extends State<DividendsScreen> {
  late List<dynamic> dividends;
  bool isLoading = false;

  Future<void> _getDividendsData() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(Uri.parse(ApiProvider.api + 'dividends')  , headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        dividends = jsonResponse["data"]["dividends"]["data"];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _getDividendsData();
    super.initState();
  }

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
              'Dividends',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            DividendsListWidget(transactions: dividends)
          ],
        ));
  }
}

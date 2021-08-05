import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class ShareholderPackagesScreen extends StatefulWidget {
  static const routeName = '/shareholderPackages';

  @override
  _ShareholderPackagesScreenState createState() =>
      _ShareholderPackagesScreenState();
}

class _ShareholderPackagesScreenState extends State<ShareholderPackagesScreen> {
  bool isLoading = false;
  late List<dynamic> packages;
  Future<void> getPackages() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
        Uri.parse(ApiProvider.api + 'packages/share'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        packages = jsonResponse["data"]["packages"];
        isLoading = false;
      });
    }
  }

  SliverList _getSlivers(List<dynamic> package, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  package[index]["title"],
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ))
                        ],
                      )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Investment Amount'),
                              Text('\$ 500.00',
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('Interest Rate'),
                              Text('12.00%',
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        },
        childCount: package.length,
      ),
    );
  }

  @override
  void initState() {
    getPackages();
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
            : CustomScrollView(
                slivers: <Widget>[
                  new SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: new SliverToBoxAdapter(
                        child: Text(
                      'Shareholder Packages',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  _getSlivers(packages, context),
                ],
              ));
  }
}

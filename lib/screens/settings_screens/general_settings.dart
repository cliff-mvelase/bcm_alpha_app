import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GeneralSettings extends StatefulWidget {
  static const routeName = '/generalSettings';

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  var bitcoinaddressController = TextEditingController();
  var banknameController = TextEditingController();
  var accountnumberController = TextEditingController();
  var branchcodeController = TextEditingController();
  var swiftcodeController = TextEditingController();
  dynamic userSettings;
  int _radioValue = -1;
  bool isLoading = false;

  void _handleRadioValueChange(int ? value)  => {
    setState(() {
      _radioValue = value! ;
      //CODE TO SEND THE VALUE
    })
  };

  Future<void> getUserSettings() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
       Uri.parse( ApiProvider.api + 'settings'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        userSettings = jsonResponse["data"]["settings"];
        if (userSettings.length != 0) {
          bitcoinaddressController.text = userSettings[0]["bitcoin_address"];
          if (userSettings[0]["alert_type"] == "Email") {
            _radioValue = 0;
          } else {
            _radioValue = 1;
          }
        }

        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getUserSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/LogoSolid.png',
            fit: BoxFit.cover, height: 50, scale: 2),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userSettings.length == 0
              ? Center(child: Text("You do not have any settings."))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'General Settings',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Preferred Currency',
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                controller: bitcoinaddressController,
                                decoration: InputDecoration(
                                  hintText: 'Bitcoin Address',
                                ),
                                onSubmitted: (_) => null,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Bank Name',
                                ),
                                onSubmitted: (_) => null,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Account Number',
                                ),
                                onSubmitted: (_) => null,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Branch Code',
                                ),
                                onSubmitted: (_) => null,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Swift Code',
                                ),
                                onSubmitted: (_) => null,
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                'Alert Type?',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                          value: 0,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange ),
                                      Text(
                                        'Email',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                          value: 1,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange),
                                      Text(
                                        'SMS',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

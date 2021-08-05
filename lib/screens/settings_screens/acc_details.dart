import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AccountDetails extends StatefulWidget {
  static const routeName = '/accountDetails';

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool isLoading = false;
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  dynamic userData;

  Future<void> getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
        Uri.parse(ApiProvider.api + 'getUserInfo'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        userData = jsonResponse["data"]["user"];
        firstnameController.text = userData["first_name"];
        lastnameController.text = userData["last_name"];
        emailController.text = userData["email"];
        isLoading = false;
      });
    }
  }

  Future<void> updateUserDetails() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.post(
      Uri.parse(ApiProvider.api + 'updatepassword'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'first_name': firstnameController.text,
        'last_name': lastnameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text
      }),
    );

    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        isLoading = false;
        print(jsonResponse["data"]["message"]);
        showAlertDialog(jsonResponse["data"]["message"]);
      });
    }
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
              FlatButton(
                onPressed: () {
                  //  Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  Navigator.of(context).pushNamed(TabsScreen.routeName);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    getUserDetails();
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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Account Details',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: firstnameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                            ),
                            onSubmitted: (_) => null,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                            ),
                            onSubmitted: (_) => null,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                            onSubmitted: (_) => null,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            onSubmitted: (_) => null,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                            ),
                            onSubmitted: (_) => null,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: () {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  Toast.show("Password do not match", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                } else if (passwordController.text == null) {
                                  Toast.show(
                                      "Please complete both password text",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                } else {
                                  updateUserDetails();
                                }
                              },
                              child: Text(
                                'Update',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
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

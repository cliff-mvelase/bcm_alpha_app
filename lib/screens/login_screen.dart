import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/register_screen.dart';
import 'package:bcm_alpha_app/screens/reset_password.dart';
import 'package:bcm_alpha_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key ? key}) : super(key: key);
  static const routeName = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  static var uri = 'http://140.82.39.29/api/login';

  Future<void> userLogin() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _nameController.text,
        'password': _passwordController.text
      }),
    );
    setState(() {
      isLoading = false;
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        isLoading = false;
      });
      sharedPrefs.setString("token", jsonResponse["data"]["token"]);
      Navigator.of(context).pushNamed(TabsScreen.routeName);
    } else {
      setState(() {
        isLoading = false;
      });
      Toast.show("Incorrect email or password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .viewInsets
              .top + 90,
          right: 14,
          left: 14,
          bottom: 8,
        ),
        //child: Column(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: (mediaQuery.height) * 0.25,
                child: Image.asset(
                  'assets/images/LogoWhite.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox( height: 70.0,),
              TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox( height: 18.0,),
              TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 45.0,),
              Container(
                alignment: Alignment.centerRight,
                height: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(160.0, 16.0, 160.0, 16.0),
                    primary: Colors.white70,
                    textStyle: const TextStyle(fontSize: 20,),
                    side: BorderSide(color: Colors.white60, width: 1),
                  ),
                  onPressed: () {
                    if (_nameController.text != "" ||
                        _passwordController.text != "") {
                      userLogin();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Container(
                height: (mediaQuery.height) * 0.2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.blueGrey,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: const Text('Register'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.blueGrey,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ResetPassword.routeName);
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ]),
              ),
        ],
          ),
        ),
      ),
    );
  }
}
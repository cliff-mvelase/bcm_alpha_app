import 'dart:convert' as convert;
import 'dart:convert';

import 'package:bcm_alpha_app/screens/register_screen.dart';
import 'package:bcm_alpha_app/screens/reset_password.dart';
import 'package:bcm_alpha_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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


    void showColoredToast() {
    Fluttertoast.showToast(
        msg: "This is Colored Toast",
        toastLength: Toast.LENGTH_SHORT,
  
    );
  }

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

      Fluttertoast.showToast(
        msg: "Invoice Email or Password !!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
        child: SingleChildScrollView(
          child: Column(
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
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w300)
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white60, fontSize: 20.0, fontWeight: FontWeight.w400)
              ),
              SizedBox( height: 18.0,),
              TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w300)
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white60, fontSize: 20.0, fontWeight: FontWeight.w400)
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
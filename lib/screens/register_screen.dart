import 'dart:convert';
import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/dashboard.dart';
import 'package:bcm_alpha_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse(ApiProvider.api + 'register'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json"
      },
      body: jsonEncode(<String, String>{
        'first_name': firstnameController.text,
        'last_name': lastnameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        isLoading = false;
        sharedPrefs.setString("token", jsonResponse["data"]["token"]);
        Navigator.of(context).pushNamed(Dashboard.routeName);
      });
    } else {
       Fluttertoast.showToast(
        msg: "Something went wrong!!!",
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
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewInsets.top + 60,
                right: 15,
                left: 15,
                bottom: 10,
              ),

              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: (mediaQuery.height) * 0.20,
                      child: Image.asset(
                        'assets/images/LogoWhite.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: (mediaQuery.height) * 0.07,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 149, 0, 1),
                        ),
                      ),
                    ),
                    TextField(
                      // style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        labelText: 'First Name(s)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controller: firstnameController,
                      keyboardType: TextInputType.emailAddress,

                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controller: lastnameController,
                      keyboardType: TextInputType.visiblePassword,

                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.visiblePassword,

                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,

                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      obscureText: true,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,

                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 100,
                      child: TextButton(
                        onPressed: () {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                       Fluttertoast.showToast(
                            msg: "Something went wrong!!!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                          } else {
                            register();
                          }
                        },
                        child: Text('Register'),
                        
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: (mediaQuery.height) * 0.2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: Text(
                                'Login',
                              ),
                              
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              // ],
              // ),
            ),
    );
  }
}

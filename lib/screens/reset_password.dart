import 'dart:convert';
import 'dart:io';


import 'package:bcm_alpha_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



class ResetPassword extends StatefulWidget {
  static const routeName = '/reset_password';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var emailController = TextEditingController();
  bool isLoading = false;
  static var url = 'http://140.82.39.29/api/forgot_password';

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json"
      },
      body: jsonEncode(<String, String>{'email': emailController.text}),
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
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
             SizedBox(height: 100.0),
              Container(
                child: Text(
                  'Enter the email address you used when you registered and we will send you temporary password.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox( height: 50,),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),

                controller: emailController,
                keyboardType: TextInputType.visiblePassword,

              ),
              SizedBox(height: 40.0),
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
                    if (emailController.text != "") {
                      resetPassword();
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
                  },
                  child: Text('Reset'),

                ),
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

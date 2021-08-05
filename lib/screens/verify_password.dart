import 'package:bcm_alpha_app/screens/resend_email.dart';
import 'package:flutter/material.dart';

class VerifyPassword extends StatelessWidget {
  static const routeName = '/verify_password';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("BCM Holdings-Register"),
      ),
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
              Container(
                alignment: Alignment.centerLeft,
                height: (mediaQuery.height) * 0.2,
                child: Text(
                  'Verify Your Email Address',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 149, 0, 1),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                // height: (mediaQuery.height) * 0.2,
                child: Text(
                  'Before proceeding, please check your email for a verification link. If you did not receive the email :',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ResendPassword.routeName);
                },
                child: Text('Click here to request another'),
                textColor: Color.fromRGBO(255, 149, 0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

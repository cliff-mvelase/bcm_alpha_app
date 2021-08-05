import 'package:flutter/material.dart';

class ResendPassword extends StatelessWidget {
  static const routeName = '/resend_password';
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
              Container(
                alignment: Alignment.centerLeft,
                height: (mediaQuery.height) * 0.15,
                child: Text(
                  'Verify Your Email Address',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 149, 0, 1),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  'A new verification link has been sent to you email address.',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 149, 0, 1),
                    fontSize: 23,
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

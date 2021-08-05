import 'package:flutter/material.dart';

class KYC extends StatelessWidget {
  static const routeName = '/kyc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/LogoSolid.png',
            fit: BoxFit.cover, height: 50),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Padding(
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onSubmitted: (_) => null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
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
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      onSubmitted: (_) => null,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'NATIONAL ID/ PASSPORT/ DRIVERS LICENSE',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'PROOF OF ADDRESS',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          //Navigator.of(context).pushNamed(TabsScreen.routeName);
                        },
                        child: Text(
                          'Submit',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
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

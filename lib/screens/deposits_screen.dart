import 'package:flutter/material.dart';

class DepositsScreen extends StatefulWidget {
  @override
  _DepositsScreenState createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<DepositsScreen> {
  int _radioValue = -1;

  void _handleRadioValueChange(int ? value) {
    setState(() {
      _radioValue = value as int;
      //CODE TO SEND THE VALUE
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'From',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Select Account',
                    ),
                    onSubmitted: (_) => null,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'To',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Add/Select Payee',
                    ),
                    onSubmitted: (_) => null,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Amount',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Tsh Enter Amount',
                    ),
                    onSubmitted: (_) => null,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'What sort of payment is this?',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange),
                          Text(
                            'Once-off',
                            style: Theme.of(context).textTheme.headline4,
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
                            'Repeat Payment',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    //height: 100,
                    child: FlatButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed(TabsScreen.routeName);
                      },
                      child: Text(
                        'Accept Payment',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

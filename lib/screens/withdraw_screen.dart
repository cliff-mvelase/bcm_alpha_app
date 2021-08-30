import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  bool isSwitched = false;
  // void _handleRadioValueChange(int value) {
  //   setState(() {
  //     _radioValue = value;
  //     //CODE TO SEND THE VALUE
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
                //  ToggleSwitch(
                //   initialLabelIndex: 0,
                //   minWidth: 160.0,
                //   activeFgColor: Colors.orangeAccent,
                //   activeBgColor: Colors.blueGrey,
                //   labels: ['Withdraw Bitcoin', 'Withdraw Fiat'],
                //   onToggle: (index) {
                //     print('switched to: $index');
                //   },
                // ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                ),

                Text(
                  'Amount USD',
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
                  'When do you want to withdraw the payment?',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Column(
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     new Radio(
                    //         value: 0,
                    //         groupValue: _radioValue,
                    //         // onChanged: _handleRadioValueChange),
                    //     Text(
                    //       'Once-off',
                    //       style: Theme.of(context).textTheme.headline4,
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     new Radio(
                    //         value: 1,
                    //         groupValue: _radioValue,
                    //         onChanged: _handleRadioValueChange),
                    //     Text(
                    //       'Repeat Payment',
                    //       style: Theme.of(context).textTheme.headline4,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  //height: 100,
                  child: TextButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed(TabsScreen.routeName);
                    },
                    child: Text(
                      'Withdraw Payment',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void toggle() {}
}

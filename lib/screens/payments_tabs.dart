import 'package:bcm_alpha_app/screens/dividends_screen.dart';
import 'package:bcm_alpha_app/screens/latest_payouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';

class PaymentsTabs extends StatefulWidget {
  static const routeName = 'PaymentsTabs';
  @override
  _PaymentsTabsState createState() => _PaymentsTabsState();
}

class _PaymentsTabsState extends State<PaymentsTabs> with SingleTickerProviderStateMixin
{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: LightColor.navyBlue1,
            bottom: const TabBar(
              tabs: [
                Tab( child: TitleText(text: "Payouts", color: Colors.white70,), ),
                Tab(child: TitleText(text: "Dividends", color: Colors.white70),),
              ],
            ),
            title: const Text('Payments'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align (
                  alignment: Alignment.topCenter,
                  child: TabBarView(
                    children: [
                      LatestPayoutsScreen(),
                      DividendsScreen(),
                    ],
                  ),
                ),
                Positioned(
                  left: -140,
                  top: -290,
                  child: CircleAvatar(
                    radius: 170,
                    backgroundColor: LightColor.lightBlue2,
                  ),
                ),
                Positioned(
                  left: -130,
                  top: -300,
                  child: CircleAvatar(
                    radius: 170,
                    backgroundColor: LightColor.lightBlue1,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';

import 'package:bcm_alpha_app/screens/withdraw_bitcoin.dart';
import 'package:bcm_alpha_app/screens/withdraw_fiat.dart';

class WithdrawalsTabs extends StatefulWidget {
  static const routeName = 'TransactionsTabs';
  @override
  _WithdrawalsTabsState createState() => _WithdrawalsTabsState();
}

class _WithdrawalsTabsState extends State<WithdrawalsTabs> with SingleTickerProviderStateMixin
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
                Tab(child: TitleText(text: "Fiat", color: Colors.white70),),
                Tab( child: TitleText(text: "Bitcoin", color: Colors.white70,), ),
              ],
            ),
            title: const Text('Withdrawals'),
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
                        WithdrawalFiatScreen(),
                        WithdrawBitcoinScreen(),
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
                // _buttonWidget(),
              ],
            ),
          )),
    );
  }
}


import 'package:bcm_alpha_app/screens/investment_contract.dart';
import 'package:bcm_alpha_app/screens/shared_contract.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';

class ContractsTabs extends StatefulWidget {
  static const routeName = 'ContractsTabs';

  @override
  _ContractsTabsState createState() => _ContractsTabsState();
}

class _ContractsTabsState extends State<ContractsTabs> with SingleTickerProviderStateMixin
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
                Tab(child: TitleText(text: "Shareholder", color: Colors.white,),),
                Tab(child: TitleText(text: "Investment", color: Colors.white,),),
              ],
            ),
            title: const Text('Contracts'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: TabBarView(
                    children: [
                      SharedContract(),
                      InvestmentContract(),
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

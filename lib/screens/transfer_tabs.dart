import 'package:bcm_alpha_app/screens/transfer_funds.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';


class TransferTabs extends StatefulWidget {
  static const routeName = 'TransferTabs';
  @override
  _TransferTabsState createState() => _TransferTabsState();
}

class _TransferTabsState extends State<TransferTabs> with SingleTickerProviderStateMixin
{
  late TabController _tabController;
  late List<Map<String, Widget>> _pages;

  @override
  void initState() {
    _pages = [
      { 'page': TransferFundsScreen(),}
    ];
    super.initState();
    _tabController = new TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab( text: 'Transfers',),
            ],
          ),
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
                      TransferFundsScreen(),
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

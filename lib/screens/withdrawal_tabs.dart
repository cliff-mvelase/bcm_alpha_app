import 'package:bcm_alpha_app/screens/withdraw_bitcoin.dart';
import 'package:bcm_alpha_app/screens/withdraw_fiat.dart';
import 'package:flutter/material.dart';

class WithdrawalsTabs extends StatefulWidget {
  static const routeName = 'TransactionsTabs';

  @override
  _WithdrawalsTabsState createState() => _WithdrawalsTabsState();
}

class _WithdrawalsTabsState extends State<WithdrawalsTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
 late List<Map<String, Widget>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      // {
      //   'page': DepositsScreen(),
      // },
      {
        'page': WithdrawBitcoinScreen(),
      },
      {
        'page': WithdrawalFiatScreen(),
      }
    ];
    super.initState();
    _tabController = new TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {});
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/LogoSolid.png',
            fit: BoxFit.cover, height: 50),
        backgroundColor: Theme.of(context).canvasColor,
        // currentIndex: _selectedPageIndex,
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Theme.of(context).accentColor,
          labelColor: Colors.white,
          onTap: _selectPage,
          tabs: [
            // Tab(
            //   text: 'Deposits',
            // ),
            Tab(
              text: 'Withdraw Bitcoin',
            ),
            Tab(
              text: 'Withdraw Fiat',
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}

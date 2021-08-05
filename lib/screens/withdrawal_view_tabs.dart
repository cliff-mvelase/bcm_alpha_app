import 'package:bcm_alpha_app/screens/withdrawal_view_cancelled_rqst_screen.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_pending__rqst_screen.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_processed_rqst_screen.dart';
import 'package:flutter/material.dart';

class WithdrawalsViewTabs extends StatefulWidget {
  static const routeName = 'WithdrawalsViewTabs';

  @override
  _WithdrawalsViewTabsState createState() => _WithdrawalsViewTabsState();
}

class _WithdrawalsViewTabsState extends State<WithdrawalsViewTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, Widget>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': WithdrawalViewPendingReqstScreen(),
      },
      {
        'page': WithdrawalViewProcessedReqstScreen(),
      },
      {
        'page': WithdrawalViewCancelledReqstScreen(),
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
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Processed',
            ),
            Tab(
              text: 'Cancelled',
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}

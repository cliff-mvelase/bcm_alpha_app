import 'package:bcm_alpha_app/screens/bottom_navigation_bar.dart';
import 'package:bcm_alpha_app/screens/contracts_options_screen.dart';
import 'package:bcm_alpha_app/screens/dashboard.dart';
import 'package:bcm_alpha_app/screens/dashboard_screen.dart';
import 'package:bcm_alpha_app/screens/settings_screen.dart';
import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabsScreen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Widget>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Dashboard(),
      },
      {
        'page': InvestmentsScreen(),
      },
      {
        'page': ContractsOptionsScreen(),
      },
      {
        'page': SettingsScreen(),
      }
    ];
    super.initState();
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
        title: Padding(
          padding: EdgeInsets.fromLTRB(220.0, 0, 0, 0),
          child: Image.asset('assets/images/LogoSolid.png',
              fit: BoxFit.cover, height: 35.0),
        ),
        leading: new Container(),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigation(),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   backgroundColor: Theme.of(context).canvasColor,
      //   selectedItemColor: Theme.of(context).accentColor,
      //   unselectedItemColor: Colors.white,
      //   currentIndex: _selectedPageIndex,
      //   type: BottomNavigationBarType.shifting,
      //   items: [
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).canvasColor,
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).canvasColor,
      //       icon: Icon(Icons.attach_money),
      //       label: 'Investments',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).canvasColor,
      //       icon: Icon(Icons.file_copy_outlined),
      //       label: 'Contracts',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).canvasColor,
      //       label: 'Settings',
      //       icon: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
    );
  }
}

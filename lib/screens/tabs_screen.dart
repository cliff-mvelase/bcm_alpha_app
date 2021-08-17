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
  bool isLoading = false;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      { 'page': Dashboard(), },
      { 'page': InvestmentsScreen(),},
      { 'page': ContractsOptionsScreen(),},
      { 'page': SettingsScreen(),}
    ];
    super.initState();
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
      body: isLoading ? Center(child: CircularProgressIndicator()) : _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

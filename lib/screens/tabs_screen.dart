import 'package:bcm_alpha_app/screens/bottom_navigation_bar.dart';
import 'package:bcm_alpha_app/screens/contracts_options_screen.dart';
import 'package:bcm_alpha_app/screens/dashboard.dart';
import 'package:bcm_alpha_app/screens/login_screen.dart';
import 'package:bcm_alpha_app/screens/my_contracts.dart';
import 'package:bcm_alpha_app/screens/settings_screen.dart';
import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

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
    super.initState();
    _pages = [
      { 'page': Dashboard(), },
      { 'page': InvestmentsScreen(),},
      { 'page': ContractsOptionsScreen(),},
      { 'page': SettingsScreen(),}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Center(
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundColor: LightColor.navyBlue1,
                  child: Image.asset('assets/images/LogoSolid.png'),
                ),
              ),
                accountName: Text(""),
                accountEmail: Text(""),
                // accountName: Text( "user",
                //   style: GoogleFonts.mulish(
                //       textStyle: Theme.of(context).textTheme.headline4,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.white54)),
                // accountEmail: Text( "user@gmail.com",
                //   style: GoogleFonts.mulish(
                //       textStyle: Theme.of(context).textTheme.headline4,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.blueGrey[700])),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor:
                //       Theme.of(context).platform == TargetPlatform.iOS
                //           ? Colors.blue
                //           : Colors.white,
                //   child: Text(
                //     "J",
                //     style: TextStyle(fontSize: 40.0),
                //   ),
                // ),
              ),
            ListTile(
              leading: Icon(Icons.share),
              title:  Text( "Contracts",
                  style: GoogleFonts.mulish(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700])),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Contracts()));
              },
            ),
            ListTile(
                leading: Icon(Icons.inventory),
                title:  Text( "Inventory",
                  style: GoogleFonts.mulish(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700])),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Contracts()));
                },
            ),
            ListTile(
                leading: Icon(Icons.payment),
                title:  Text( "Payments",
                  style: GoogleFonts.mulish(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700])),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Contracts()));
                },
            ),
            ListTile(
                leading: Icon(Icons.people),
                title:  Text( "Packages",
                  style: GoogleFonts.mulish(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700])),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Contracts()));
                },
            ),
            SizedBox(height: 300),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title:  Text( "Logout",
                  style: GoogleFonts.mulish(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700])),
              onTap: () {
                isLoading = false;
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: LightColor.navyBlue1,
        title: Padding(
          padding: EdgeInsets.fromLTRB(220.0, 0, 0, 0),
          child: Image.asset('assets/images/LogoSolid.png',
              fit: BoxFit.cover, height: 35.0),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) : _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

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

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': TransferFundsScreen(),
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
        // body: _pages[_selectedPageIndex]['page'],
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
                      // Expanded(
                      //   flex: 1,
                      //   child: SizedBox(),
                      // ),
                      // Container(
                      //   height: 55,
                      //   width: 60,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           image: NetworkImage(
                      //               "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
                      //           fit: BoxFit.cover),
                      //       borderRadius: BorderRadius.all(Radius.circular(15))),
                      // ),
                      // Text(
                      //   'Sending money to User',
                      //   style: TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w700,
                      //       color: Colors.white),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //     width: 130,
                      //     padding:
                      //     EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: LightColor.navyBlue2,
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(15))),
                      //     child: Text(
                      //        "10,000",
                      //     )),
                      // Expanded(
                      //   flex: 2,
                      //   child: SizedBox(),
                      // )
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
                // Positioned(
                //   top: MediaQuery.of(context).size.height * .6,
                //   right: -180,
                //   child: CircleAvatar(
                //     radius: 100,
                //     backgroundColor: LightColor.yellow2,
                //   ),
                // ),
                // Positioned(
                //   top: MediaQuery.of(context).size.height * .6,
                //   right: -200,
                //   child: CircleAvatar(
                //     radius: 120,
                //     backgroundColor: LightColor.yellow,
                //   ),
                // ),
                // Positioned(
                //     left: 0,
                //     top: 40,
                //     child: Row(
                //       children: <Widget>[
                //         BackButton(color: Colors.white,),
                //         SizedBox(width: 20),
                //         TitleText(
                //           text: " Withdraw ",
                //           color: Colors.white,
                //         )
                //       ],
                //     )),
                // _buttonWidget(),
              ],
            ),
          )),
      );
  }
}

//start
import 'package:bcm_alpha_app/screens/investment_contract.dart';
import 'package:bcm_alpha_app/screens/shared_contract.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';

import 'package:bcm_alpha_app/screens/withdraw_bitcoin.dart';
import 'package:bcm_alpha_app/screens/withdraw_fiat.dart';

class ContractsTabs extends StatefulWidget {
  static const routeName = 'ContractsTabs';

  @override
  _ContractsTabsState createState() => _ContractsTabsState();
}

class _ContractsTabsState extends State<ContractsTabs> with SingleTickerProviderStateMixin
{

  // late TabController _tabController;
  // late List<Map<String, Widget>> _pages;
  // int _selectedPageIndex = 0;
  //
  // @override
  // void initState() {
  //   _pages = [
  //     {
  //       'page': WithdrawBitcoinScreen(),
  //     },
  //     {
  //       'page': WithdrawalFiatScreen(),
  //     }
  //   ];
  //   super.initState();
  //   _tabController = new TabController(length: _pages.length, vsync: this);
  //   _tabController.addListener(() {});
  // }

  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });
  // }
  //
  // Align _buttonWidget() {
  //   return Align(
  //       alignment: Alignment.bottomCenter,
  //       child: Container(
  //           height: MediaQuery.of(context).size.height * .48,
  //           decoration: BoxDecoration(
  //               color: Theme.of(context).backgroundColor,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(40),
  //                   topRight: Radius.circular(40))),
  //           child: Column(
  //             children: <Widget>[
  //
  //               _transferButton()
  //             ],
  //           )));
  // }

  // Widget _transferButton() {
  //   return Container(
  //       margin: EdgeInsets.only(bottom: 20),
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       decoration: BoxDecoration(
  //           color: LightColor.navyBlue2,
  //           borderRadius: BorderRadius.all(Radius.circular(15))),
  //       child: Wrap(
  //         children: <Widget>[
  //           Transform.rotate(
  //             angle: 70,
  //             child: Icon(
  //               Icons.swap_calls,
  //               color: Colors.white,
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Text(
  //            "Transfer",
  //           ),
  //         ],
  //       ));
  // }

  // Widget _icon(IconData icon, bool isBackground) {
  //   return Container(
  //       margin: EdgeInsets.all(10),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Container(
  //             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //             decoration: BoxDecoration(
  //                 color: isBackground
  //                     ? LightColor.lightGrey
  //                     : Theme.of(context).backgroundColor,
  //                 borderRadius: BorderRadius.all(Radius.circular(8))),
  //             child: Icon(icon),
  //           ),
  //           !isBackground
  //               ? SizedBox()
  //               : Text(
  //             "Change",
  //             style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //                 color: LightColor.navyBlue2),
  //           )
  //         ],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(child: TitleText(text: "Shared", color: Colors.white,),),
                Tab(child: TitleText(text: "Invested", color: Colors.white,),),
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

//end
// import 'package:bcm_alpha_app/screens/withdraw_bitcoin.dart';
// import 'package:bcm_alpha_app/screens/withdraw_fiat.dart';
// import 'package:flutter/material.dart';
//
// class WithdrawalsTabs extends StatefulWidget {
//   static const routeName = 'TransactionsTabs';
//   @override
//   _WithdrawalsTabsState createState() => _WithdrawalsTabsState();
// }
//
// class _WithdrawalsTabsState extends State<WithdrawalsTabs> with SingleTickerProviderStateMixin
// {
//   late TabController _tabController;
//   late List<Map<String, Widget>> _pages;
//
//   int _selectedPageIndex = 0;
//
//   @override
//   void initState() {
//     _pages = [
//       {
//         'page': WithdrawBitcoinScreen(),
//       },
//       {
//         'page': WithdrawalFiatScreen(),
//       }
//     ];
//     super.initState();
//     _tabController = new TabController(length: _pages.length, vsync: this);
//     _tabController.addListener(() {});
//   }
//
//   void _selectPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Image.asset('assets/images/LogoSolid.png',
//             fit: BoxFit.cover, height: 50),
//         backgroundColor: Theme.of(context).canvasColor,
//         // currentIndex: _selectedPageIndex,
//         bottom: TabBar(
//           controller: _tabController,
//           unselectedLabelColor: Theme.of(context).accentColor,
//           labelColor: Colors.white,
//           onTap: _selectPage,
//           tabs: [
//             Tab(
//               text: 'Withdraw Bitcoin',
//             ),
//             Tab(
//               text: 'Withdraw Fiat',
//             ),
//           ],
//         ),
//       ),
//       body: _pages[_selectedPageIndex]['page'],
//     );
//   }
// }

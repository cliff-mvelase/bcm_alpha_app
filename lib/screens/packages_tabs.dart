//start
import 'package:bcm_alpha_app/screens/withdrawal_view_cancelled_rqst_screen.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_pending__rqst_screen.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_processed_rqst_screen.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';

class PackagesTabs extends StatefulWidget {
  static const routeName = 'PackagesTabs';
  @override
  _PackagesTabsState createState() => _PackagesTabsState();
}

class _PackagesTabsState extends State<PackagesTabs> with SingleTickerProviderStateMixin
{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab( child: TitleText(text: "Investment Packages", color: Colors.white70,), ),
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
                      Text("1111"),
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
              ],
            ),
          )),
    );
  }
}
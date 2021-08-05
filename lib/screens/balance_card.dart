import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bcm_alpha_app/screens/transfer_tabs.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';

class BalanceCard extends StatefulWidget {
   final dynamic walletData;
   BalanceCard({Key ?  key ,required this.walletData}) : super(key: key);

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {

  @override
  Widget build(BuildContext context) {
    final dynamic walletData;
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .27,
            color: LightColor.navyBlue1,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Wallet Balance,',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: LightColor.lightNavyBlue),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text(
                          ' USD: ',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: LightColor.yellow.withAlpha(200)),
                        ),
                        Text(
                          ' ${walletData["total"]}',
                          style: GoogleFonts.mulish(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: LightColor.yellow2),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'BTC: ',
                          style: GoogleFonts.mulish(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: LightColor.lightNavyBlue),
                        ),
                        Text(
                          ' ${walletData["total_btc"]} ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                              margin: EdgeInsets.all(30.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(TransferTabs.routeName);
                                      },
                                      child: Text("Withdraw"))
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                              margin: EdgeInsets.all(30.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.transfer_within_a_station,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Transfer",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              )),
                        )
                      ],
                    ),],
                ),
                Positioned(
                  left: -170,
                  top: -170,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue2,
                  ),
                ),
                Positioned(
                  left: -160,
                  top: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue1,
                  ),
                ),
                Positioned(
                  right: -170,
                  bottom: -170,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.yellow2,
                  ),
                ),
                Positioned(
                  right: -160,
                  bottom: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.yellow,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

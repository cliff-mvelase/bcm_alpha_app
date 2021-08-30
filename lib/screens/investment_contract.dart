import 'package:bcm_alpha_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:bcm_alpha_app/screens/theme/light_color.dart';
import 'package:bcm_alpha_app/screens/tile_text.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentContract extends StatefulWidget {
  static const routeName = 'InvestmentContract';

  InvestmentContract({Key ? key}) : super(key: key);
  @override
  _InvestmentContractState createState() => _InvestmentContractState();
}

class _InvestmentContractState extends State<InvestmentContract> {

  late dynamic shareholderData;

  Dashboard dashboard = new Dashboard();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

  }


  Align _buttonWidget() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: MediaQuery.of(context).size.height * .48,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                TitleText(
                  text: "Contracts Details",
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _sharedList(),
                ),
              ],
            )));
  }
  // ${shareholderData["capital_invested_usd"]}
  // ${shareholderData["number_of_shares"]}
  // ${shareholderData["contracts"]["number_of_contracts"]}
  Widget _sharedList() {
    return Column(
      children: <Widget> [
        _transaction("INVESTED", "capital",  '123465' ),
        _transaction("CONTRACTS", "Count", '321'),
      ],
    );
  }

  Widget _transaction(String text, String time, shareholderData) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: LightColor.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(shareholderData,
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.navyBlue2))),
    );
  }

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

  // Widget _countButton(String text) {
  //   return Material(
  //       child: InkWell(
  //           onTap: () {
  //             print("Sfsf");
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             child: Text(
  //               text,
  //             ),
  //           )));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      'Investment Contract',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 130,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: LightColor.navyBlue2,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        child: TitleText(
                          text: "\$10,000",
                          color: Colors.white70,
                        )),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),

                  ],
                ),
              ),
              Positioned(
                left: -140,
                top: -270,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue2,
                ),
              ),
              Positioned(
                left: -130,
                top: -300,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue1,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .2,
                right: -200,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .2,
                right: -200,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              ),
              _buttonWidget(),
            ],
          ),
        ));
  }
}

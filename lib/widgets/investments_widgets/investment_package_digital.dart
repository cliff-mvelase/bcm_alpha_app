import 'package:bcm_alpha_app/screens/tile_text.dart';
import 'package:flutter/material.dart';

class InvestmentPackageDigital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
               TitleText(text: "With Digital Shares", color: Colors.white70),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Invested Amount', style: TextStyle(color: Colors.white60, fontSize: 18.0, fontWeight: FontWeight.w400)),
                          SizedBox(height: 5.0,),
                          Text('\$10,000',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70)),
                          Text('BTC 1.89743', style: TextStyle(color: Colors.green)),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Profit (P/M)', style: TextStyle(color: Colors.white60, fontSize: 18.0, fontWeight: FontWeight.w400)),
                          SizedBox(height: 5.0,),
                          Text('\$350',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white70)),
                          Text('BTC 1.89743', style: TextStyle(color: Colors.green, fontSize: 12)),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Validity Duration ', style: TextStyle(color: Colors.white60, fontSize: 18.0, fontWeight: FontWeight.w400)),
                          Text('3 Years',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Interest', style: TextStyle(color: Colors.white60, fontSize: 20.0, fontWeight: FontWeight.w100)),
                          Text('3.5 %',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70)),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

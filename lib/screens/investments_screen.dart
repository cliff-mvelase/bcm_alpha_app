import 'package:bcm_alpha_app/widgets/investments_widgets/investment_package.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/investment_package_digital.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/monthly_investment.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/quartely_returns.dart';
import 'package:bcm_alpha_app/widgets/investments_widgets/semi_annual_returns.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  static const routeName = '/investmentsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('assets/images/LogoSolid.png',
      //       fit: BoxFit.cover, height: 50),
      //   backgroundColor: Theme.of(context).canvasColor,
      // ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            InvestmentPackageDigital(),
            QuaterlyReturns(),
            SemiAnnualReturns(),
            MonthlyInvestment(),
            InvestmentPackage(),
          ],
        ),
      ),
    );
  }
}

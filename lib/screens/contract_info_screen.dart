import 'package:bcm_alpha_app/widgets/contract_info_summary.dart';
import 'package:flutter/material.dart';

class ContractInfo extends StatelessWidget {
  static const routeName = '/contractInfo';

  @override
  Widget build(BuildContext context) {
    final dynamic contractInfo = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/LogoSolid.png',
              fit: BoxFit.cover, height: 50),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'Contract Information',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            ContractInfoSummary(contractData: contractInfo),
            // Text(
            //   'Payout History',
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            //  PayoutHistory(),
          ],
        ));
  }
}

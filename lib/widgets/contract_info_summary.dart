import 'package:flutter/material.dart';

class ContractInfoSummary extends StatelessWidget {
  final dynamic contractData;
  const ContractInfoSummary({Key ? key, @required this.contractData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              '\$ ${contractData["amount_invested"]}'.substring(
                                  0,
                                  contractData["amount_invested"].indexOf('.') +
                                      5),
                              style: Theme.of(context).textTheme.headline6),
                          Text('Amount Invested'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('${contractData["interest_rate"]}%',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Interest Rate'),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              '\$ ${contractData["monthly_return"]}'.substring(
                                  0,
                                  contractData["amount_invested"].indexOf('.') +
                                      3),
                              style: Theme.of(context).textTheme.headline6),
                          Text('Monthly Return'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                              '\$ ${contractData["total_contract_payout"]}'
                                  .substring(
                                      0,
                                      contractData["amount_invested"]
                                              .indexOf('.') +
                                          4),
                              style: Theme.of(context).textTheme.headline6),
                          Text('Tot Contract Payout'),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('${contractData["created_at"]}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Date'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('${contractData["status"]}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Status'),
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

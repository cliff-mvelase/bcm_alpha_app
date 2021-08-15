import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LatestPayoutWidget extends StatelessWidget {
  final List<dynamic> transactions;

  const LatestPayoutWidget({Key ? key, required this.transactions})
      : super(key: key);

  String _convertDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = dateFormatter.format(displayDate);
    return formatted;
  }

  String _numberCurrencyDisplay(String amount) {
    final formatter = new NumberFormat("#,##0.##");
    return formatter.format(double.parse(amount));
  }

  @override
  Widget build(BuildContext context) {
    DataRow _getDataRow(transactions) {
      return DataRow(
        cells: <DataCell>[
          // DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
          //   Text(_convertDateTimeDisplay(transactions["created_at"]),
          //       style: TextStyle(
          //           fontStyle: FontStyle.normal,
          //           fontWeight: FontWeight.w400,
          //           fontSize: 18,
          //           color: Colors.white70)),
          //
          // ])),
          DataCell(
              Text(_convertDateTimeDisplay(transactions["created_at"]),
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white70),
              )),
          DataCell(
                Text(transactions["trx_type"],
                style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white70),
              )),
          DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
            Text("\$ " + _numberCurrencyDisplay(transactions["amount_usd"]),
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white70)),
            Text("BTC " + _numberCurrencyDisplay(transactions["amount_btc"]),
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Colors.green))
          ])),
          DataCell(Text(
              transactions["wallet_address"] == null
                  ? "loading..."
                  : transactions["wallet_address"],
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white70))),
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.all(0),
        child: Expanded(
          flex: 1,
          child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,0,0, 20),
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            dividerThickness: 0.5,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('DATE',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
                              ),
                              DataColumn(
                                label: Text('PAYMENT',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
                              ),
                              DataColumn(
                                label: Text(
                                  'AMOUNT',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'WALLET',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)
                                ),
                              ),
                            ],
                            rows: List.generate(transactions.length,
                                (index) => _getDataRow(transactions[index])),
                          )),
                    )
                  ],
                ),
              )),
        ));
  }
}

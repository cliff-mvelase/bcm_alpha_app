import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DividendsListWidget extends StatelessWidget {
  final List<dynamic> transactions;

  const DividendsListWidget({Key ? key, required this.transactions})
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
          DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
            Text(_convertDateTimeDisplay(transactions["created_at"]),
                style: TextStyle(color: Colors.white)),
            Text(transactions["currency"],
                style: TextStyle(color: Colors.white))
          ])),
          DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Return:" + _numberCurrencyDisplay(transactions["return"]),
                style: TextStyle(color: Colors.white)),
            Text("Payout:" + _numberCurrencyDisplay(transactions["payout"]),
                style: TextStyle(color: Colors.white))
          ])),
          DataCell(Text(_numberCurrencyDisplay(transactions["profit"]),
              style: TextStyle(color: Colors.white)))
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.all(5),
        child: Expanded(
          flex: 1,
          child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
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
                                label: Text('AMOUNT',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
                              ),
                              DataColumn(
                                label: Text('PROFIT',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
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

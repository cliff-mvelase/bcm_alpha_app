import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryWidget extends StatelessWidget {
  final List<dynamic> transactions;

  const TransactionHistoryWidget({Key ? key, required this.transactions})
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
            Text(transactions["trx_type"],
                style: TextStyle(color: Colors.white))
          ])),
          DataCell(Text(
              '\$ ${_numberCurrencyDisplay(transactions["amount_usd"])}',
              style: TextStyle(color: Colors.white))),
          DataCell(Text(
              transactions["wallet_address"] == null
                  ? "N/A"
                  : transactions["wallet_address"],
              style: TextStyle(color: Colors.white))),
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dividerThickness: 0.5,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Wallet',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                        rows: List.generate(transactions.length,
                            (index) => _getDataRow(transactions[index])),
                      ))
                ],
              ),
            )));
  }
}

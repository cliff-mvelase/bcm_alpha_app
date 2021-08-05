import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawalHistoryWidget extends StatelessWidget {
  final List<dynamic> withdrawals;

  const WithdrawalHistoryWidget({Key ? key, required this.withdrawals})
      : super(key: key);

  String _convertDateTimeDisplay(String ? date) {
    late String formatted;
    if (date != null) {
      final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
      final DateTime displayDate = displayFormatter.parse(date);
      formatted = dateFormatter.format(displayDate);
    }
    return formatted;
  }

  String _numberCurrencyDisplay(String? amount) {
    late String stringAmount;
    if (amount != null) {
      final formatter = new NumberFormat("#,##0.##");
      stringAmount = formatter.format(double.parse(amount));
    }

    return stringAmount;
  }

  @override
  Widget build(BuildContext context) {
    DataRow _getDataRow(withdrawals) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
            Text(_convertDateTimeDisplay(withdrawals["created_at"]),
                style: TextStyle(color: Colors.white)),
            Text(withdrawals["type"], style: TextStyle(color: Colors.white))
          ])),
          DataCell(Text(
              '\$ ${_numberCurrencyDisplay(withdrawals["amount_usd"])}',
              style: TextStyle(color: Colors.white))),
          DataCell(Text(
              withdrawals["method"] == null ? "N/A" : withdrawals["method"],
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
                          // DataColumn(
                          //   label: Text(
                          //     'Type',
                          //     style: TextStyle(
                          //         fontStyle: FontStyle.normal,
                          //         color: Colors.white),
                          //   ),
                          // ),
                          DataColumn(
                            label: Text(
                              'Payment method',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                        rows: List.generate(withdrawals.length,
                            (index) => _getDataRow(withdrawals[index])),
                      ))
                ],
              ),
            )));
  }
}

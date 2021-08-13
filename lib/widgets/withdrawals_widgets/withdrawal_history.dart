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
        selected: true,
        cells: <DataCell>[
          DataCell(
              Text(_convertDateTimeDisplay(withdrawals["created_at"]),
              style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white70))),
          DataCell(
              Text(withdrawals["type"],
                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white70))),
          DataCell(Text(
              '\$ ${_numberCurrencyDisplay(withdrawals["amount_usd"])}',
              style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white70))),
          DataCell(Text(
              withdrawals["method"] == null ? "N/A" : withdrawals["method"],
              style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white70))),
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(0, 40.0, 0, 0),
        child: Expanded(
          flex: 1,
          child: Card(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  child:  FittedBox(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            dividerThickness: 0.5,
                            columnSpacing: 30,
                            showBottomBorder: true,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('DATE',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
                              ),
                              DataColumn(
                                label: Text(
                                  'TYPE',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'AMOUNT',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'PAYMENT METHOD ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                ),
                              ),
                            ],
                            rows: List.generate(withdrawals.length,
                                (index) => _getDataRow(withdrawals[index])),
                          )),
                  )

                ),
              )),
        ));
  }
}

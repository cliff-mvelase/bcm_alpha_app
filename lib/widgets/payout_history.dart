import 'package:flutter/material.dart';

class PayoutHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              'Payout',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Transaction ID',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                        rows: const <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('01-09-20',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('\$10',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('Done',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('001',
                                  style: TextStyle(color: Colors.white))),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('01-09-20',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('\$100',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('Pending',
                                  style: TextStyle(color: Colors.white))),
                              DataCell(Text('001',
                                  style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}

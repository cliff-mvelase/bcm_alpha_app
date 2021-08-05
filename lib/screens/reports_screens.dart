import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math' as math;

class ReportsScreen extends StatefulWidget {
  static const routeName = '/reports';
  ReportsScreen({Key ? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;
  bool isLoading = false;
  List<dynamic> instrumentslist = [];
  late List<dynamic> trade_resultslist;
  late List<dynamic> trade_reportslist;

  Future<void> getReports() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
        Uri.parse(ApiProvider.api + 'reports'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        instrumentslist =
            convert.jsonDecode(jsonResponse["data"]["data"]["intruments"]);
        trade_resultslist =
            convert.jsonDecode(jsonResponse["data"]["data"]["trade_results"]);
        trade_reportslist =
            convert.jsonDecode(jsonResponse["data"]["data"]["trade_reports"]);
        print(trade_reportslist);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getReports();
    _pages = [
      {
        'page': ReportChart(),
      },
      {
        'page': ResultChart(),
       }
       //,
      // {
      //   'page': InstrumentChart(this),
      // }
    ];
    _tabController = new TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {});
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/LogoSolid.png',
            fit: BoxFit.cover, height: 50),
        backgroundColor: Theme.of(context).canvasColor,
        // currentIndex: _selectedPageIndex,
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Theme.of(context).accentColor,
          labelColor: Colors.white,
          onTap: _selectPage,
          tabs: [
            Tab(
              text: 'Reports',
            ),
            Tab(
              text: 'Results',
            )
            // ,
            // Tab(
            //   text: 'Instruments',
            // ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}

class ReportChart extends StatefulWidget {
  ReportChart({Key ? key}) : super(key: key);

  @override
  _ReportChartState createState() => _ReportChartState();
}

class _ReportChartState extends State<ReportChart> {
  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Daily',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Total',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Won',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Lost',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                  height: 400,
                  child: charts.BarChart(
                    _createSampleData(),
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    domainAxis: new charts.OrdinalAxisSpec(
                        renderSpec: new charts.SmallTickRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 12,
                                color: charts.MaterialPalette.white))),

                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 12, 
                                color: charts.MaterialPalette.white),
                            lineStyle: new charts.LineStyleSpec(
                                thickness: 1,
                                color: charts.MaterialPalette.black))),
                    behaviors: [new charts.SeriesLegend()],
                  )),
            ),
          ),
        ));
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class ResultChart extends StatefulWidget {
  ResultChart({Key ? key}) : super(key: key);

  @override
  _ResultChartState createState() => _ResultChartState();
}

class _ResultChartState extends State<ResultChart> {
  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Daily',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Total',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Won',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Lost',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                child: charts.BarChart(_createSampleData(),
                    animate: true,
                    domainAxis: new charts.OrdinalAxisSpec(
                        renderSpec: new charts.SmallTickRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 12,
                                color: charts.MaterialPalette.white))),
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 12, 
                                color: charts.MaterialPalette.white),
                            lineStyle: new charts.LineStyleSpec(
                                thickness: 1,
                                color: charts.MaterialPalette.black))),
                    barGroupingType: charts.BarGroupingType.grouped),
              ),
            ),
          ),
        ));
  }
}

class InstrumentChart extends StatelessWidget {
  _ReportsScreenState parent;
  InstrumentChart(this.parent);

  static List<charts.Series<LinearSales, dynamic>> _createSampleData(
      _ReportsScreenState parent) {
    List<LinearSales> data = [];
    for (int x = 0; x < parent.instrumentslist.length; x++) {
      data.add(new LinearSales(
          parent.instrumentslist[x]["instrument"],
          0,
          double.parse(parent.instrumentslist[x]["number_of_trades"])
              .round()
              .toInt(),
          charts.ColorUtil.fromDartColor(
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0))));
    }

    return [
      new charts.Series<LinearSales, dynamic>(
        id: 'Currencies',
        domainFn: (LinearSales sales, _) => sales.name,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Container(
                  height: 1000,
                  child: charts.PieChart(
                    _createSampleData(parent),
                    animate: true,
                    behaviors: [
                      new charts.DatumLegend(
                        position: charts.BehaviorPosition.bottom,
                        horizontalFirst: false,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}

class LinearSales {
  final String name;
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.name, this.year, this.sales, this.color);
}

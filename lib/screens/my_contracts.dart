import 'dart:io';

import 'package:bcm_alpha_app/network/api_provider.dart';
import 'package:bcm_alpha_app/screens/contract_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Contracts extends StatefulWidget {
  static const routeName = '/mycontracts';
  Contracts({Key ? key}) : super(key: key);

  @override
  _ContractsState createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {
  bool isLoading = false;
  late List<dynamic> contracts;

  Future<void> getContracts() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token") ?? null;
    var response = await http.get(
    Uri.parse(ApiProvider.api + 'contracts'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["data"]["status"] == "success") {
      setState(() {
        contracts = jsonResponse["data"]["contracts"]["data"];
        isLoading = false;
      });
    }
  }

  List<Widget> populateContracts(List<dynamic> contracts) {
    List<Widget> contractWidgetList = [];
    for (int x = 0; x < contracts.length; x++) {
      contractWidgetList.add(ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ContractInfo.routeName, arguments: contracts[x]);
        },
        title: Text(contracts[x]["id_number"]),
        subtitle: Text(contracts[x]["created_at"]),
        trailing: Icon(Icons.folder_open, color: Colors.white),
      ));
      if (x < contracts.length - 1) {
        contractWidgetList.add(Divider());
      }
    }
    return contractWidgetList;
  }

  @override
  void initState() {
    getContracts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/LogoSolid.png',
            fit: BoxFit.cover, height: 50),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Text(
                  'My Contracts',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                          child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: populateContracts(contracts),
                      )),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bcm_alpha_app/network/api_provider.dart';

class DataProvider with ChangeNotifier{

  static var uri = ApiProvider.api + 'login';
  bool isLoading = false;

  //user authorization
  Future<void> userLogin() async {

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var jsonResponse = convert.jsonDecode(response.body);


      sharedPrefs.setString("token", jsonResponse["data"]["token"]);



  }


}
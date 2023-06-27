import 'package:advisory_app/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Baseapi {
  static var base = "oyster-app-m5xd2.ondigitalocean.app/api/auth/login/";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password});

    http.Response response = await http.post(
        Uri.https('oyster-app-m5xd2.ondigitalocean.app', '/api/auth/login/'),
        headers: headers,
        body: body);
    print(response.body);
    return response;
  }

  Future<http.Response> logout() async {
    http.Response response = await http.post(
      Uri.https('oyster-app-m5xd2.ondigitalocean.app', '/api/auth/logout/'),
      headers: headers,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = (prefs.getString('username') ?? '');
    return response;
  }

  Future<http.Response> getUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Token $token"
    };
    http.Response response = await http.get(
      Uri.https('oyster-app-m5xd2.ondigitalocean.app', '/api/user/$username'),
      headers: headers,
    );
    return response;
  }
   Future<List<UserModel>> getUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Token $token"
    };
    http.Response response = await http.get(
      Uri.https('oyster-app-m5xd2.ondigitalocean.app', '/api'),
      headers: headers,
    );


    if (response.statusCode == 200) {
      return UserModel.fromJsonList(json);
    } else {
      throw Exception('Request Failed.');
    }
    print(response.body);
   
  }




 
}

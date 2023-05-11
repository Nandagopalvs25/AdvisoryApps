import 'package:http/http.dart' as http;
import 'dart:convert';

class Baseapi {
  static var base = "advisoryapi-t8cai.ondigitalocean.app/api/auth/login/";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<http.Response> login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password});

    http.Response response = await http.post(
        Uri.https('advisoryapi-t8cai.ondigitalocean.app', '/api/auth/login/'),
        headers: headers,
        body: body);
    print(response.body);
    return response;
  }

  Future<http.Response> logout() async {
    http.Response response = await http.post(
      Uri.https('advisoryapi-t8cai.ondigitalocean.app', '/api/auth/logout/'),
      headers: headers,
    );
    
    print(response.body);
    print(response.statusCode);
    return response;
  }

   Future<http.Response> getUser(String username) async {
    Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Authorization": "Token b5f0825d48921c47dcf45109f520e9985634ba87"
  };
    http.Response response = await http.get(
      Uri.https('advisoryapi-t8cai.ondigitalocean.app', '/api/user/$username'),
      headers: headers,
    );
    print(response.body);
    print(response.statusCode);
    return response;
  }



}

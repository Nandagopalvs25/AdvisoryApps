import 'package:advisory_app/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userId = "";
  String _token = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = (prefs.getString('username') ?? "");
    _token = (prefs.getString('token') ?? "");

    Baseapi api = Baseapi();
    var res = await api.getUser(_userId);

    if (_userId == "") {
      Navigator.of(context)?.pushNamedAndRemoveUntil(RouteGenerator.loginPage, (Route<dynamic> route) => false);
    }
      else if (res.statusCode == 200) {
        Navigator.of(context)?.pushNamedAndRemoveUntil(RouteGenerator.homePage, (Route<dynamic> route) => false);
      }
      else{
        Navigator.of(context)?.pushNamedAndRemoveUntil(RouteGenerator.loginPage, (Route<dynamic> route) => false);
      }
    }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

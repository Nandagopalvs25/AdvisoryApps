import 'dart:convert';

import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advisory'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _username,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Username'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          TextButton(
              onPressed: () async {
                final username = _username.text;
                final password = _password.text;
                Baseapi api = Baseapi();
                var res = await api.login(username, password);
                if (res.statusCode == 200) {
                  Map<String, dynamic> user = jsonDecode(res.body);
                  String token = user['key'];
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString("username", (username));
                  await prefs.setString("token", token);

                  Navigator.of(context)?.pushNamedAndRemoveUntil(
                      RouteGenerator.homePage, (Route<dynamic> route) => false);
                }
              },
              child: Text('Log in'))
        ],
      ),
    );
    ;
  }
}

import 'dart:convert';

import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:advisory_app/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: Center(
              child: Image.network(
                  'https://ist7-1.filesor.com/pimpandhost.com/2/9/8/7/298728/f/t/u/x/ftuxN/Screenshot__42_-removebg-preview.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: _username,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(style: BorderStyle.solid)),
                labelText: 'Username',
                icon: const FaIcon(FontAwesomeIcons.user),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                iconColor: const Color.fromARGB(164, 23, 134, 135),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 141, 39, 243),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                iconColor: const Color.fromARGB(164, 23, 134, 135),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Password',
                icon: const FaIcon(FontAwesomeIcons.key),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 141, 39, 243),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 130,
            child: ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(225, 255, 187, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 245, 224, 255))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.rightToBracket),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Log in",
                    style: GoogleFonts.firaSans(
                        fontSize: 20,
                        color: const Color.fromARGB(211, 161, 0, 137)),
                  )
                ],
              ),
            ),
          )
         
        ],
      ),
    );
  }
}

import 'package:advisory_app/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          child: const Text("Logout"),
          onPressed: () async {
            Baseapi api = Baseapi();
            api.logout();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('username');
            Navigator.of(context, rootNavigator: true)
                ?.pushNamedAndRemoveUntil(RouteGenerator.loginPage, (Route<dynamic> route) => false);
          }),
    );
  }
}

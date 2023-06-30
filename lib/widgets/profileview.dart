import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  final String username;

  const ProfileView({super.key, required this.username});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getUser(widget.username),
          builder: ((context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[Text(snapshot.data?.username ?? ""),Text(snapshot.data?.admission_number ?? "")];
              
            } else {
              children = <Widget>[Text("No data")];
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
          })),
    );
  }
}

Future<UserModel> getUser(String username) async {
  Baseapi api = Baseapi();
  http.Response res = await api.getUser(username);

  var user = UserModel.fromReqBody(res.body);

  return user;
  //String json = jsonEncode(user);
  //print(json);
}

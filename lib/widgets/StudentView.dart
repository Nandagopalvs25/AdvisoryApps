import 'dart:convert';

import 'package:advisory_app/api.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentView extends StatefulWidget {
  final String username;
  const StudentView({super.key, required this.username});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  final username_ctrl = TextEditingController();
  final batch_ctrl = TextEditingController();
  final admnno_ctrl = TextEditingController();
  final email_ctrl = TextEditingController();
  final phoneno_ctrl = TextEditingController();
  final dob_ctrl = TextEditingController();
  final guardian_ctrl = TextEditingController();
  final guardianno_ctrl = TextEditingController();
  final remarks_ctrl = TextEditingController();

  @override
  void dispose() {
    username_ctrl.dispose();
    batch_ctrl.dispose();
    admnno_ctrl.dispose();
    email_ctrl.dispose();
    phoneno_ctrl.dispose();
    dob_ctrl.dispose();
    guardian_ctrl.dispose();
    guardianno_ctrl.dispose();
    remarks_ctrl.dispose();
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Student Profile",style: GoogleFonts.robotoCondensed(fontSize: 30),),),
      body: FutureBuilder<UserModel>(
        future: getUser(widget.username),
        builder: (ctx, snapshot) {
          username_ctrl.text = snapshot.data?.username ?? "";
          batch_ctrl.text = snapshot.data?.batch ?? "";
          admnno_ctrl.text = snapshot.data?.admission_number ?? "";
          email_ctrl.text = snapshot.data?.email ?? "";
          phoneno_ctrl.text = snapshot.data?.phone_no ?? "";
          dob_ctrl.text = snapshot.data?.dob ?? "";
          guardian_ctrl.text = snapshot.data?.guardian ?? "";
          guardianno_ctrl.text = snapshot.data?.guardian_no ?? "";
          remarks_ctrl.text = snapshot.data?.teacher_remarks ?? "";
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView(
              padding: const EdgeInsets.all(9),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://media.discordapp.net/attachments/996754697849405540/1106485239670386719/profile.jpeg?width=400&height=400'),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Username: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: username_ctrl,
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Batch: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                      child: TextFormField(controller: batch_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Admn no: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(controller: admnno_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(43, 10, 10, 10),
                      child: TextFormField(controller: email_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Phone no: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(controller: phoneno_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "DOB: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                      child: TextFormField(controller: dob_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Guardian: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: TextFormField(controller: guardian_ctrl),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Guardian\nno: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(23, 10, 10, 10),
                      child: TextFormField(controller: guardianno_ctrl),
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Text(
                          "Remarks: ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                        child: Container(
                            child: TextFormField(
                                controller: remarks_ctrl, maxLines: null)),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green)),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String token = (prefs.getString('token') ?? '');
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8",
                        "Authorization": "Token $token"
                      };

                      var body = jsonEncode({
                        'username': username_ctrl.text,
                        'email': email_ctrl.text,
                        'batch': batch_ctrl.text,
                        'admission_number': admnno_ctrl.text,
                        'dob': DateTime.tryParse(dob_ctrl.text ?? ''),
                        'phone_no': phoneno_ctrl.text,
                        'guardian': guardian_ctrl.text.toString(),
                        'guardian_no': guardianno_ctrl.text,
                        'teacher_remarks': remarks_ctrl.text
                      });

                      String? usr = snapshot.data!.username;
                      http.Response response = await http.put(
                          Uri.https('oyster-app-m5xd2.ondigitalocean.app',
                              '/api/user/$usr'),
                          headers: headers,
                          body: body);
                      print(response.body);
                      if (response.statusCode == 200) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Updated Succesfully'),
                         
                            actions: <Widget>[
                             
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {}

          return Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
      ),
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

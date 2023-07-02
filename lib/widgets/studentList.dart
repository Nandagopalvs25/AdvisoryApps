import 'dart:convert';
import 'dart:ui';

import 'package:advisory_app/api.dart';
import 'package:advisory_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/userModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colorloader.dart';

const List<String> list = <String>['All', 'B22ECA', 'B22ECB'];
String batch = "All";

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  final TextEditingController _searchController = TextEditingController();
  String dropdownValue = list.first;
  String usern = "";
  bool showTextField = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(usern, batch),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Students",
                  style: GoogleFonts.robotoCondensed(fontSize: 30),
                ),
              ),
              backgroundColor: const Color.fromARGB(47, 29, 87, 86),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search..',
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                usern = _searchController.text;
                              });
                            }),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 2)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const FaIcon(FontAwesomeIcons.sort),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      batch = value;
                      usern = _searchController.text;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(RouteGenerator.studentprofilePage,
                                    arguments: snapshot.data![index]
                                        ['username']);
                          },
                          title: Text(snapshot.data![index]['username']),
                          subtitle: Text(snapshot.data![index]['batch']),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[200],
                            backgroundImage: const NetworkImage(
                                "https://media.discordapp.net/attachments/996754697849405540/1106485239670386719/profile.jpeg?width=400&height=400"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Students",
                style: GoogleFonts.robotoCondensed(fontSize: 30),
              ),
            ),
            backgroundColor: const Color.fromARGB(47, 29, 87, 86),
          ),
          backgroundColor: const Color.fromARGB(47, 29, 87, 86),
          body: Center(
            child: ColorLoader5(
              dotOneColor: Colors.redAccent,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: const Icon(
                Icons.adjust,
              ),
              duration: const Duration(seconds: 1),
            ),
          ),
        );
      },
    );
  }
}

Future<List<dynamic>> fetchData(String username, String batch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = (prefs.getString('token') ?? '');
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Authorization": "Token $token"
  };

  String ur = 'oyster-app-m5xd2.ondigitalocean.app';

  if (username != "" && batch == "All") {
    final queryParameters = {
      'search': username,
    };
    http.Response response = await http.get(
      Uri.https('$ur', '/api/', queryParameters),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return List.empty();
    }
  } else if (batch == "All") {
    final queryParameters = {
      'search': username,
    };
    http.Response response = await http.get(
      Uri.https('$ur', '/api/', queryParameters),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return List.empty();
    }
  } else if (username != "" && batch != "") {
    final queryParameters = {'search': username, 'batch': batch};
    http.Response response = await http.get(
      Uri.https('$ur', '/api/', queryParameters),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return List.empty();
    }
  } else if (username != "") {
    final queryParameters = {
      'search': username,
    };
    http.Response response = await http.get(
      Uri.https('$ur', '/api/', queryParameters),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return List.empty();
    }
  } else if (batch != "") {
    final queryParameters = {'batch': batch};
    http.Response response = await http.get(
      Uri.https('$ur', '/api/', queryParameters),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return List.empty();
    }
  } else {
    return List.empty();
  }
}

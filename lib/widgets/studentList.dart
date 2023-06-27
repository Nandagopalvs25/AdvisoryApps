import 'dart:convert';

import 'package:advisory_app/api.dart';
import 'package:advisory_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(usern, batch),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Search..',
                          prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  usern = _searchController.text;
                                });
                              }),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
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
                            leading: Icon(Icons.arrow_right_alt_rounded),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
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
      Uri.https(
          '$ur', '/api/', queryParameters),
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
      Uri.https(
          '$ur', '/api/', queryParameters),
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
      Uri.https(
          '$ur', '/api/', queryParameters),
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
      Uri.https(
          '$ur', '/api/', queryParameters),
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
      Uri.https(
          '$ur', '/api/', queryParameters),
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

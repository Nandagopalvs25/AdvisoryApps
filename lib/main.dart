import 'package:advisory_app/routes.dart';
import 'package:advisory_app/widgets/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advisory App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RouteGenerator.landingPage,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

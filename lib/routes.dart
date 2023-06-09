import 'package:advisory_app/certificates.dart';
import 'package:advisory_app/models/userModel.dart';
import 'package:advisory_app/widgets/StudentView.dart';
import 'package:advisory_app/widgets/homepage.dart';
import 'package:advisory_app/widgets/landingpage.dart';
import 'package:advisory_app/widgets/login_screen.dart';
import 'package:advisory_app/widgets/profileview.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String loginPage = '/';
  static const String homePage = '/homepage';
  static const String landingPage = '/landing';
  static const String studentprofilePage = '/studentView';
  static const String studentEditPage = '/studentEdit';
  static const String certificatePage = '/certificate';

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const login(),
        );

      case homePage:
        // return MaterialPageRoute(
        //   builder: (_) => const HomePage(),
        // );
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case landingPage:
        return MaterialPageRoute(builder: (_) => Landing());

      case studentprofilePage:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (
          _,
        ) =>
                ProfileView(username: args));

      case studentEditPage:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (
          _,
        ) =>
                StudentView(username: args));

       case certificatePage:
        final args = settings.arguments as List<Activity>;
        return MaterialPageRoute(
            builder: (
          _,
        ) =>
                Certificates(acts: args));
      
      default:
        throw FormatException("Route not found");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:purple/screens/Single.dart';
import 'package:purple/screens/feed.dart';
import 'package:purple/screens/login.dart';
import 'package:purple/screens/login_signup.dart';
import 'package:purple/screens/signup.dart';
import 'package:purple/screens/welcome.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Welcome());
      case '/loginorsignup':
        return MaterialPageRoute(
          builder: (_) => LoginOrSignup(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => Signup(),
        );
      case '/feed':
        return MaterialPageRoute(
          builder: (_) => Feed(),
        );
      case '/single':
        return MaterialPageRoute(
          builder: (_) => Single(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

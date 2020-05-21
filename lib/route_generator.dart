import 'package:flutter/material.dart';
import 'package:purple/screens/Single.dart';
import 'package:purple/screens/create_post.dart';
import 'package:purple/screens/feed.dart';
import 'package:purple/screens/login.dart';
import 'package:purple/screens/login_signup.dart';
import 'package:purple/screens/profile.dart';
import 'package:purple/screens/signup.dart';
import 'package:purple/screens/user_posts.dart';
import 'package:purple/screens/welcome.dart';
import 'package:purple/services/auth.dart';

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
        print(args);
        if (args != null) {
          return MaterialPageRoute(
            builder: (_) => Feed(),
          );
        } else {
          print(AuthService().user);
          return MaterialPageRoute(
            builder: (_) => Login(),
          );
        }
        break;
      case '/single':
        return MaterialPageRoute(
          builder: (_) => Single(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => Profile(),
        );
      case '/create':
        return MaterialPageRoute(
          builder: (_) => CreatePost(),
        );
      case '/profile/posts':
        return MaterialPageRoute(
          builder: (_) => UserPosts(),
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

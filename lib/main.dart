import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/models/user.dart';
import 'package:purple/route_generator.dart';
import 'package:flutter/services.dart';
import 'package:purple/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/feed',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:purple/route_generator.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/profile/posts',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

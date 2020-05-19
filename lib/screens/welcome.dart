import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(150.0, -100.0),
              child: Image.asset('assets/Ellipse4.png'),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(170.0, -100.0),
              child: Image.asset('assets/Ellipse6.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: Offset(-150.0, 100.0),
              child: Image.asset('assets/Ellipse5.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: Offset(-170.0, 110.0),
              child: Image.asset('assets/Ellipse7.png'),
            ),
          ),
        ],
      ),
    );
  }
}

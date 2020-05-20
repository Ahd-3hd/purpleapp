import 'package:flutter/material.dart';

class Single extends StatefulWidget {
  @override
  _SingleState createState() => _SingleState();
}

class _SingleState extends State<Single> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: MediaQuery.of(context).size.width + 150,
                    left: -50,
                    top: 0,
                    child: Image.asset(
                      'assets/appbarbottom.png',
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width + 150,
                    left: -50,
                    top: -15,
                    child: Image.asset(
                      'assets/appbarmiddle.png',
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width + 150,
                    left: -50,
                    top: -25,
                    child: Image.asset(
                      'assets/appbartop.png',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 7,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      elevation: 0,
                      onPressed: () {},
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

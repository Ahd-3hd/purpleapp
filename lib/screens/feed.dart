import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
        title: Text('Purple'),
        elevation: 7,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[const Color(0xff8E2DE2), const Color(0xff4A00E0)],
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}

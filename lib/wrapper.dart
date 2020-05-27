import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/ohscreens/authenticate.dart';
import 'package:purple/ohscreens/home.dart';

import 'package:purple/ohmodels/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Home();
    } else {
      return AuthenticateScreen();
    }
  }
}

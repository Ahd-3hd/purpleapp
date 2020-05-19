import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  @override
  _LoginOrSignupState createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset('assets/banner.png'),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    width: 400,
                    child: Image.asset(
                      'assets/loginsignupbgbelow.png',
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 50,
                    width: 310,
                    child: Image.asset(
                      'assets/loginsignupbgtop.png',
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 65,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(130.0),
                          bottomRight: Radius.circular(130.0),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: 280,
                        height: 270,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                print('hh');
                              },
                              color: const Color(0xffB513A4),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              "or if you don't have an account",
                              style: TextStyle(
                                color: const Color(0xffB513A4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                print('hh');
                              },
                              color: const Color(0xffB513A4),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

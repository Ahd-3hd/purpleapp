import 'package:flutter/material.dart';
import 'package:purple/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
                          width: 280,
                          height: 270,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'Password must be at least 6 characters long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error = 'error signing in';
                                          });
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              '/feed',
                                              arguments: result.uid);
                                        }
                                      }
                                    },
                                    color: const Color(0xffB513A4),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

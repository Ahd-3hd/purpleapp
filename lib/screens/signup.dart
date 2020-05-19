import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String repeatPassword = '';
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 50),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
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
                                  ),
                                  Expanded(
                                    child: TextFormField(
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
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                      ),
                                      validator: (val) => val != password
                                          ? 'Passwords must match'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          repeatPassword = val;
                                        });
                                      },
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        print(email);
                                        print(password);
                                      }
                                    },
                                    color: const Color(0xffB513A4),
                                    child: Text(
                                      'CREATE',
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

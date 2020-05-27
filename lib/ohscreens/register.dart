import 'package:flutter/material.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/wrapper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String repeatPassword;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset('assets/banner.png'),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff8E2DE2),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Repeat Password',
                      ),
                      validator: (val) => repeatPassword != password
                          ? 'Password must match'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          repeatPassword = val;
                        });
                      },
                    ),
                    RaisedButton(
                      color: const Color(0xffB513A4),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  'error creating account, check your credentials';
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()));
                          }
                        }
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(error)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

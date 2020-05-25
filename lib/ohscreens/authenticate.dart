import 'package:flutter/material.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Image.asset(
                          'assets/ohtoprightbottom.png',
                          width: MediaQuery.of(context).size.width / 1.4,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Image.asset(
                          'assets/ohtopright.png',
                          width: MediaQuery.of(context).size.width / 1.45,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: Offset(0.0, 0.0),
                        child: Image.asset(
                          'assets/toprightvector.png',
                          fit: BoxFit.fitHeight,
                          height: MediaQuery.of(context).size.height / 2.7,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedBuilder(
                        animation: _controller.view,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                _controller.value * 10, _controller.value * 10),
                            child: child,
                          );
                        },
                        child: Transform.translate(
                          offset: Offset(10.0, 30.0),
                          child: Image.asset(
                            'assets/sell.png',
                            fit: BoxFit.fitHeight,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedBuilder(
                        animation: _controller.view,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                _controller.value * 10, _controller.value * 10),
                            child: child,
                          );
                        },
                        child: Transform.translate(
                          offset: Offset(_controller.value * 5 + 100,
                              _controller.value * 15 + 130),
                          child: Image.asset(
                            'assets/hire.png',
                            fit: BoxFit.fitHeight,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedBuilder(
                        animation: _controller.view,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                _controller.value * 20, _controller.value * 20),
                            child: child,
                          );
                        },
                        child: Transform.translate(
                          offset: Offset(50.0, 220.0),
                          child: Image.asset(
                            'assets/buy.png',
                            fit: BoxFit.fitHeight,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Welcome to Purple',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'ALREADY A MEMBER?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xffB513A4),
                      ),
                      Text(
                        'or create a new one..',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xffB513A4),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(0.0, 20.0),
              child: Image.asset(
                'assets/toprightvector.png',
                fit: BoxFit.fitHeight,
                height: 250,
              ),
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
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Transform.translate(
                  offset:
                      Offset(_controller.value * 10, _controller.value * 10),
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
                  offset:
                      Offset(_controller.value * 10, _controller.value * 10),
                  child: child,
                );
              },
              child: Transform.translate(
                offset: Offset(
                    _controller.value * 5 + 110, _controller.value * 15 + 140),
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
                  offset:
                      Offset(_controller.value * 20, _controller.value * 20),
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
          Align(
            alignment: Alignment.center,
            child: Center(
              child: RaisedButton(
                color: const Color(0xffB513A4),
                onPressed: () {
                  print('hh');
                },
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

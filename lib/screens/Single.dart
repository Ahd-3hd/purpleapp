import 'package:flutter/material.dart';

class Single extends StatefulWidget {
  dynamic data;
  Single({this.data});
  @override
  _SingleState createState() => _SingleState();
}

class _SingleState extends State<Single> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8900FF),
        onPressed: () {},
        child: Icon(
          Icons.add_to_photos,
        ),
      ),
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
                  Positioned(
                    left: 0,
                    top: 7,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/feed');
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.data['imgurl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TL ${widget.data['price']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.data['location'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.data['desc'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: const Color(0xffB513A4),
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.insert_comment,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Whatsapp',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        RaisedButton(
                          color: const Color(0xffB513A4),
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Call',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        RaisedButton(
                          color: const Color(0xffB513A4),
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_comment,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Comment',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Comment(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                  ),
                  Text('username'),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed turpis lectus, hendrerit a dignissim ac, pulvinar'),
            ),
          ],
        ),
      ),
    );
  }
}

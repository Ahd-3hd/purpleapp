import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () {},
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
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/headerbg.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: User Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Location: Istanbul',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Email: email@email.com',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    child: RaisedButton(
                      color: const Color(0xffB513A4),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.view_list,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'View Posts',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Comment(),
                ],
              ),
            )
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

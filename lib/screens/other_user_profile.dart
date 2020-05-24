import 'package:flutter/material.dart';
import 'package:purple/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherUserProfile extends StatefulWidget {
  final dynamic data;
  OtherUserProfile({this.data});
  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  Map userData;

  void getUser() async {
    print(widget.data);
    dynamic fetchedData =
        await DatabaseSerivce().getUserForProfile(widget.data);
    setState(() {
      userData = fetchedData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

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
                    left: 0,
                    top: 7,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      elevation: 0,
                      onPressed: () {
                        Navigator.pop(context);
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
                          'Name: ${userData['username']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Location: ${userData['location']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Email: ${userData['email']}',
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
                        onPressed: () async {
                          if (await canLaunch(
                              "whatsapp://send?phone=${userData['whatsAppNumber']}")) {
                            await launch(
                                "whatsapp://send?phone=${userData['whatsAppNumber']}");
                          } else {
                            throw 'Could not launch ';
                          }
                        },
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
                        onPressed: () async {
                          if (await canLaunch(
                              "tel:${userData['phoneNumber']}")) {
                            await launch("tel:${userData['phoneNumber']}");
                          } else {
                            throw 'Could not launch ';
                          }
                        },
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
                        onPressed: () {
                          Navigator.of(context).pushNamed('/profilecomment',
                              arguments: widget.data);
                        },
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
                  Comment(commentData: userData['comments']),
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
  final dynamic commentData;
  const Comment({Key key, this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(commentData);
    return Column(
        children: commentData
            .map<Widget>(
              (singleComment) => Card(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                            ),
                            Flexible(child: Text(singleComment['username'])),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(singleComment['comment']),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}

import 'package:flutter/material.dart';
import 'package:purple/ohscreens/create_comment.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class Single extends StatefulWidget {
  final data;
  final itemDocId;
  Single({this.data, this.itemDocId});
  @override
  _SingleState createState() => _SingleState();
}

class _SingleState extends State<Single> {
  final AuthService _auth = AuthService();
  dynamic opData;

  void getOpData() async {
    dynamic result = await DatabaseSerivce().getUser(widget.data['userid']);

    setState(() {
      opData = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getOpData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                if (await _auth.signOut()) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Wrapper()));
                }
              },
              child: Text('sign out', style: TextStyle(color: Colors.white))),
          IconButton(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
        title: Text('Purple'),
        elevation: 7,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[const Color(0xff8E2DE2), const Color(0xff4A00E0)],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  child: Image.network(
                    widget.data['imgurl'],
                    fit: BoxFit.cover,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.grey[850],
                      ),
                      SizedBox(width: 10),
                      Text(
                        opData['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[850],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 20.0,
                            color: const Color(0xff4A00E0),
                          ),
                          Text(
                            widget.data['location'],
                            style: TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xff4A00E0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.data['title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff4A00E0),
                        ),
                      ),
                      Text(
                        'TL ${widget.data['price']}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff4A00E0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.data['desc'],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[850],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: const Color(0xffB513A4),
                        onPressed: () async {
                          if (await canLaunch(
                              "whatsapp://send?phone=${widget.data['whatsAppNumber']}")) {
                            await launch(
                                "whatsapp://send?phone=${widget.data['whatsAppNumber']}");
                          } else {
                            throw 'Could not launch ${widget.data['whatsAppNumber']}';
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
                              "tel:${widget.data['phoneNumber']}")) {
                            await launch("tel:${widget.data['phoneNumber']}");
                          } else {
                            throw 'Could not launch ${widget.data['phoneNumber']}';
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
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateComment(
                                itemDocId: widget.itemDocId,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_comment,
                              color: Colors.grey[850],
                            ),
                            Text(
                              'Comment',
                              style: TextStyle(
                                color: Colors.grey[850],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.data['comments'].map<Widget>((single) {
                      return Comment(
                        comment: single,
                      );
                    }).toList(),
                    // [
                    //   Comment(
                    //     comment: widget.data['comments'][0],
                    //   ),
                    // ]
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final Map comment;
  Comment({this.comment});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  String commentorUsername;
  void getCommentorData() async {
    dynamic result = await DatabaseSerivce().getUser(widget.comment['userid']);

    setState(() {
      commentorUsername = result['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCommentorData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.grey[850],
                ),
                Text(commentorUsername),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(widget.comment['comment']),
            )
          ],
        ),
      ),
    );
  }
}

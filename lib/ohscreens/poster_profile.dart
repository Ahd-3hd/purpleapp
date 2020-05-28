import 'package:flutter/material.dart';
import 'package:purple/ohscreens/comment_on_profile.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class PosterProfile extends StatefulWidget {
  final Map data;
  final String posteruid;
  PosterProfile({this.data, this.posteruid});
  @override
  _PosterProfileState createState() => _PosterProfileState();
}

class _PosterProfileState extends State<PosterProfile> {
  final AuthService _auth = AuthService();

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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.data['avatar']),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Username: ${widget.data['username']}',
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 18,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Email: ${widget.data['email']}',
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 18,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Location: ${widget.data['location']}',
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 18,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
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
                    if (await canLaunch("tel:${widget.data['phoneNumber']}")) {
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
                        builder: (context) =>
                            CommentOnProfile(profileid: widget.posteruid),
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
            widget.data['comments'] != null
                ? Column(
                    children: widget.data['comments'].map<Widget>((single) {
                      return Comment(
                        comment: single,
                      );
                    }).toList(),
                  )
                : Text('No Comments'),
          ],
        ),
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

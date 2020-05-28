import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/ohmodels/user.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';

class CreateComment extends StatefulWidget {
  final itemDocId;
  CreateComment({this.itemDocId});
  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final AuthService _auth = AuthService();

  String commentText;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
        title: Text('New Comment'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter A comment',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Enter a a comment' : null,
                    onChanged: (val) {
                      setState(() {
                        commentText = val;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: RaisedButton(
                      color: const Color(0xffB513A4),
                      onPressed: () async {
                        await DatabaseSerivce()
                            .commentOnPost(
                                user.uid, widget.itemDocId, commentText)
                            .then((value) => Navigator.of(context).pop());
                        //  Navigator.of(context).pop();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_comment,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

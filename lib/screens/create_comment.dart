import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/models/user.dart';
import 'package:purple/services/auth.dart';
import 'package:purple/services/database.dart';

class CreateComment extends StatefulWidget {
  final docid;
  CreateComment({this.docid});
  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final AuthService _auth = AuthService();
  String comment;

  // Future uploadFile(userid) async {
  //   StorageReference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('productimg/$userid/${Path.basename(_image.path)}');
  //   StorageUploadTask uploadTask = storageReference.putFile(_image);
  //   await uploadTask.onComplete;
  //   storageReference.getDownloadURL().then((fileURL) async {
  //     await DatabaseSerivce().createComment(userid);
  //     setState(() {
  //       isUploaded = true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8900FF),
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/feed');
        },
        child: Icon(
          Icons.arrow_back,
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
                    top: 2,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      onPressed: () async {
                        if (await _auth.signOut()) {
                          Navigator.of(context).popAndPushNamed('/login');
                        }
                      },
                      child: Text(
                        'logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: ListView(
                    children: [
                      Text(widget.docid),
                      Container(
                        child: TextFormField(
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Write a comment',
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter a comment' : null,
                          onChanged: (val) {
                            setState(() {
                              comment = val;
                            });
                          },
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Post'),
                              onPressed: () async {
                                await DatabaseSerivce().createComment(
                                    user.uid, widget.docid, comment);
                                Navigator.of(context).pop();
                              },
                              color: Colors.cyan,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

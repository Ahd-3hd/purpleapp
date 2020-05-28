import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/ohmodels/user.dart';
import 'package:purple/ohservices/database.dart';

class CreateComment extends StatefulWidget {
  final itemDocId;
  CreateComment({this.itemDocId});
  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  String commentText;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
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

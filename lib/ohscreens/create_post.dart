import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:provider/provider.dart';
import 'package:purple/ohmodels/user.dart';
import 'package:purple/ohscreens/current_user_profile.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final AuthService _auth = AuthService();
  File _image;
  bool isUploaded = false;
  String postTitle;
  String postCategory;
  String postDesc;
  String postKeywordOne;
  String postKeywordTwo;
  String postKeywordThree;
  String postLocation;
  String postPrice;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile(userid) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        '/productimg/${Timestamp.now().nanoseconds}${Timestamp.now().seconds}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      dynamic userData = await DatabaseSerivce().getUser(userid);
      await DatabaseSerivce().createPost(
          userid,
          postTitle,
          postDesc,
          postCategory,
          [postKeywordOne, postKeywordTwo, postKeywordThree],
          fileURL,
          postLocation,
          postPrice,
          userData['phoneNumber'],
          userData['whatsAppNumber']);
    });
    setState(() {
      isUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (isUploaded) {
      return Wrapper();
    }
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CurrentUserProfile(userid: user.uid)));
            },
          ),
        ],
        title: Text('New Post'),
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
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Make sure to edit your profile information otherwise people will not be able to reach you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              validator: (val) => val.isEmpty ? 'Enter a title' : null,
              onChanged: (val) {
                setState(() {
                  postTitle = val;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Location',
              ),
              validator: (val) => val.isEmpty ? 'Enter Location' : null,
              onChanged: (val) {
                setState(() {
                  postLocation = val;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Price',
              ),
              validator: (val) => val.isEmpty ? 'Enter Price' : null,
              onChanged: (val) {
                setState(() {
                  postPrice = val;
                });
              },
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<String>(
                hint: Text('Category'),
                value: postCategory,
                items:
                    <String>['Product', 'Service', 'Job'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {
                  setState(() {
                    postCategory = _;
                  });
                },
              ),
            ),
            TextFormField(
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              validator: (val) => val.isEmpty ? 'Enter a a description' : null,
              onChanged: (val) {
                setState(() {
                  postDesc = val;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Keyword 1',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a keyword' : null,
                      onChanged: (val) {
                        setState(() {
                          postKeywordOne = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Keyword 2',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a keyword' : null,
                      onChanged: (val) {
                        setState(() {
                          postKeywordTwo = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Keyword 3',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a keyword' : null,
                      onChanged: (val) {
                        setState(() {
                          postKeywordThree = val;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Choose Image',
                        style: TextStyle(color: Colors.white)),
                    onPressed: chooseFile,
                    color: Colors.cyan,
                  ),
                  Container(
                    height: _image != null ? 200 : 0,
                    child: _image != null
                        ? (Image.asset(_image.path))
                        : Text('Choose Image'),
                  ),
                  RaisedButton(
                    child: Text('Post', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      await uploadFile(user.uid);
                    },
                    color: Colors.cyan,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

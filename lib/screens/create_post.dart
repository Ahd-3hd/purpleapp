import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/models/user.dart';
import 'package:purple/screens/feed.dart';
import 'package:purple/services/auth.dart';
import 'package:purple/services/database.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
  final AuthService _auth = AuthService();
  String categoryValue;
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile(userid) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('productimg/$userid/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      await DatabaseSerivce().createPost(
          userid,
          postTitle,
          postDesc,
          postCategory,
          [postKeywordOne, postKeywordTwo, postKeywordThree],
          fileURL,
          postLocation,
          postPrice);
      setState(() {
        isUploaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return !isUploaded
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF8900FF),
              onPressed: () async {
                await uploadFile(user.uid);
              },
              child: Icon(
                Icons.create,
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
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a title' : null,
                                onChanged: (val) {
                                  setState(() {
                                    postTitle = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Location',
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter Location' : null,
                                onChanged: (val) {
                                  setState(() {
                                    postLocation = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Price',
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter Price' : null,
                                onChanged: (val) {
                                  setState(() {
                                    postPrice = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                hint: Text('Category'),
                                value: postCategory,
                                items: <String>['Product', 'Service', 'Job']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  setState(() {
                                    postCategory = _;
                                  });
                                  print(postCategory);
                                },
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                minLines: 5,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'Enter a a description'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    postDesc = val;
                                  });
                                },
                              ),
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
                                      validator: (val) => val.isEmpty
                                          ? 'Enter a keyword'
                                          : null,
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
                                      validator: (val) => val.isEmpty
                                          ? 'Enter a keyword'
                                          : null,
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
                                      validator: (val) => val.isEmpty
                                          ? 'Enter a keyword'
                                          : null,
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
                                    child: Text('Choose Image'),
                                    onPressed: chooseFile,
                                    color: Colors.cyan,
                                  ),
                                  RaisedButton(
                                    child: Text('Post'),
                                    onPressed: () async {
                                      await uploadFile(user.uid);
                                    },
                                    color: Colors.cyan,
                                  ),
                                  Container(
                                    height: 200,
                                    child: _image != null
                                        ? (Image.asset(_image.path))
                                        : Text('Choose Image'),
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
          )
        : Feed();
  }
}

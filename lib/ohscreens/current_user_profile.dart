import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/ohmodels/user.dart';
import 'package:purple/ohscreens/home.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class CurrentUserProfile extends StatefulWidget {
  final String userid;
  CurrentUserProfile({this.userid});
  @override
  _CurrentUserProfileState createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> {
  final AuthService _auth = AuthService();
  String username;
  String email;
  String phoneNumber;
  String whatsAppNumber;
  String location;
  String avatar =
      'https://firebasestorage.googleapis.com/v0/b/purple-aa6da.appspot.com/o/icon.png?alt=media&token=704754b4-1cca-48af-a307-ee2bd3eccfef';
  File _image;
  Future chooseAndUploadFile(uid) async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('userimg/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      return await DatabaseSerivce().updateUserProfileImage(uid, fileURL);
    });
  }

  void getUserData() async {
    Map result = await DatabaseSerivce().getUser(widget.userid);
    setState(() {
      username = result['username'];
      email = result['email'];
      location = result['location'];
      phoneNumber = result['phoneNumber'];
      whatsAppNumber = result['whatsAppNumber'];
      avatar = result['avatar'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
                        image: NetworkImage(avatar),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await chooseAndUploadFile(widget.userid);
                        },
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff33333355),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'username',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      username != null && username.isNotEmpty && username != ''
                          ? username
                          : 'username',
                ),
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Email',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: email != null && email.isNotEmpty && email != ''
                      ? email
                      : 'email address',
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Location',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      location != null && location.isNotEmpty && location != ''
                          ? location
                          : 'Location',
                ),
                onChanged: (val) {
                  setState(() {
                    location = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Phone No.',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: phoneNumber != null &&
                          phoneNumber.isNotEmpty &&
                          phoneNumber != ''
                      ? phoneNumber
                      : 'Phone No.',
                ),
                onChanged: (val) {
                  setState(() {
                    phoneNumber = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Whatsapp No.',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: whatsAppNumber != null &&
                          whatsAppNumber.isNotEmpty &&
                          whatsAppNumber != ''
                      ? whatsAppNumber
                      : 'Whatsapp No.',
                ),
                onChanged: (val) {
                  setState(() {
                    whatsAppNumber = val;
                  });
                },
              ),
            ),
            Center(
              child: Container(
                width: 100,
                child: RaisedButton(
                  color: const Color(0xffB513A4),
                  onPressed: () async {
                    await DatabaseSerivce().updateUserDataFromProfile(
                        widget.userid,
                        phoneNumber,
                        whatsAppNumber,
                        email,
                        username,
                        location);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

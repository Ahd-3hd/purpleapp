import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple/ohmodels/user.dart';
import 'package:purple/ohservices/auth.dart';
import 'package:purple/ohservices/database.dart';
import 'package:purple/wrapper.dart';

class CurrentUserProfile extends StatefulWidget {
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
  void getUserData(userid) async {
    Map result = await DatabaseSerivce().getUser(userid);
    setState(() {
      username = result['username'];
      email = result['email'];
      phoneNumber = result['phoneNumber'];
      whatsAppNumber = result['whatsAppNumber'];
      location = result['location'];
      avatar = result['avatar'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    getUserData(user.uid);
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
                  builder: (context) => CurrentUserProfile()));
            },
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
                        onPressed: () {},
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
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: username == 'Unknown' || username.isEmpty
                      ? 'Username'
                      : username,
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
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: email == 'Unknown' || email.isEmpty
                      ? 'Email Address'
                      : email,
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
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: location == 'Unknown' || location.isEmpty
                      ? 'location'
                      : location,
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
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: phoneNumber == 'Unknown' || phoneNumber.isEmpty
                      ? 'Phone Number'
                      : phoneNumber,
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
            Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      whatsAppNumber == 'Unknown' || whatsAppNumber.isEmpty
                          ? 'Phone Number'
                          : whatsAppNumber,
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
                  onPressed: () {},
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

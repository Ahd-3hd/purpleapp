import 'package:flutter/material.dart';
import 'package:purple/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final dynamic data;
  Profile({this.data});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData;
  bool editMode = false;
  String userName;
  String userEmail;
  String userPhoneNumber;
  String userWhatsAppNumber;
  String userLocation;
  void getUserData() async {
    dynamic user = await DatabaseSerivce().getUserForProfile(widget.data.uid);
    setState(() {
      userData = user;
      userName = user['username'];
      userEmail = user['email'];
      userPhoneNumber = user['phoneNumber'];
      userWhatsAppNumber = user['whatsAppNumber'];
      userLocation = user['location'];
    });
  }

  void updateUserProfileData() async {
    await DatabaseSerivce().updateUserProfileData(
        userPhoneNumber,
        userWhatsAppNumber,
        userName,
        userEmail,
        userWhatsAppNumber,
        userLocation,
        widget.data.uid);
    return Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
            !editMode
                ? Expanded(
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
                                  throw 'Could not launch ${userData['whatsAppNumber']}';
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
                                  await launch(
                                      "tel:${userData['phoneNumber']}");
                                } else {
                                  throw 'Could not launch ${userData['phoneNumber']}';
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
                                setState(() {
                                  editMode = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // RaisedButton(
                            //   color: const Color(0xffB513A4),
                            //   onPressed: () {},
                            //   child: Row(
                            //     children: <Widget>[
                            //       Icon(
                            //         Icons.add_comment,
                            //         color: Colors.white,
                            //       ),
                            //       SizedBox(width: 10),
                            //       Text(
                            //         'Comment',
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        Comment(commentData: userData['comments']),
                      ],
                    ),
                  )
                : Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a username' : null,
                            onChanged: (val) {
                              setState(() {
                                userName = val;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() {
                                userEmail = val;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Location',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a Location' : null,
                            onChanged: (val) {
                              setState(() {
                                userLocation = val;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a Phone Number' : null,
                            onChanged: (val) {
                              setState(() {
                                userPhoneNumber = val;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Whatsapp',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a whatsapp Number' : null,
                            onChanged: (val) {
                              setState(() {
                                userWhatsAppNumber = val;
                              });
                            },
                          ),
                          RaisedButton(
                            onPressed: () {
                              updateUserProfileData();
                            },
                            child: Text('save'),
                          ),
                        ],
                      ),
                    ),
                  ),
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

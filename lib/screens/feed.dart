import 'package:flutter/material.dart';
import 'package:purple/services/auth.dart';
import 'package:purple/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final AuthService _auth = AuthService();
  String categoryValue;
  String keyword;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseSerivce(categoryValue: categoryValue, keyword: keyword)
          .thePosts,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF8900FF),
            onPressed: () async {
              Navigator.of(context).pushNamed('/create');
            },
            child: Icon(
              Icons.add_to_photos,
            )),
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                itemHeight: 63,
                                hint: Text('Category'),
                                items: <String>['Product', 'Service', 'Job']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {
                                  setState(() {
                                    categoryValue = _;
                                  });
                                  print(_);
                                  print(categoryValue);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Search..',
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    keyword = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: const Color(0xFF8900FF),
                                onPressed: () {},
                                child: Text(
                                  'Filter',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    PostList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<QuerySnapshot>(context);
    // for (var doc in posts.documents) {
    //   print(doc.data);
    // }
    return Expanded(
      child: ListView(
          children: posts.documents
              .map((singleItem) => ItemCard(
                    data: singleItem,
                  ))
              .toList()),
    );
  }
}

class ItemCard extends StatelessWidget {
  final data;
  const ItemCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data['imgurl']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'TL ${data['price']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${data['location']}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: Text(
                      data['desc'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: const Color(0xffB513A4),
                        onPressed: () {},
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
                        onPressed: () {},
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
                        color: Colors.transparent,
                        elevation: 0,
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.rate_review,
                              color: Colors.grey[800],
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Reviews',
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

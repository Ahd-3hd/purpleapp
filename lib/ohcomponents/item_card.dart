import 'package:flutter/material.dart';
import 'package:purple/ohscreens/single.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatefulWidget {
  final Map itemData;
  final String itemDocId;
  ItemCard({this.itemData, this.itemDocId});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Single(
                      data: widget.itemData,
                      itemDocId: widget.itemDocId,
                    )));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.itemData['imgurl']),
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
                        widget.itemData['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'TL ${widget.itemData['price']}',
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
                            widget.itemData['location'],
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
                      widget.itemData['desc'],
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
                        onPressed: () async {
                          if (await canLaunch(
                              "whatsapp://send?phone=${widget.itemData['whatsAppNumber']}")) {
                            await launch(
                                "whatsapp://send?phone=${widget.itemData['whatsAppNumber']}");
                          } else {
                            throw 'Could not launch ';
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
                              "tel:${widget.itemData['phoneNumber']}")) {
                            await launch(
                                "tel:${widget.itemData['phoneNumber']}");
                          } else {
                            throw 'Could not launch ';
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

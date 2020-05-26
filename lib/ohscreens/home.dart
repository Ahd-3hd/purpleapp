import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String categoryValue;
  String keyword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            onPressed: () {},
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      itemHeight: 63,
                      hint: Text('Category'),
                      value: categoryValue,
                      items: <String>['Any', 'Product', 'Service', 'Job']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        if (_ != 'Any') {
                          setState(() {
                            categoryValue = _;
                          });
                        } else {
                          setState(() {
                            categoryValue = null;
                          });
                        }

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
              ],
            )
          ],
        ),
      ),
    );
  }
}

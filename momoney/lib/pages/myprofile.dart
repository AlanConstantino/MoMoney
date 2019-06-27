import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<MyProfile> {
  Widget titleSection = Stack(children: <Widget>[
    Container(
        child: Align(
            alignment: const Alignment(0, -.9),
            child: CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              radius: 65,
              child: RichText(
                text: TextSpan(
                    text: 'Your Name Here!// or picture',
                    style: TextStyle(color: Colors.black.withOpacity(0.6))),
              ),
            ))),
    Container(
      child: Align(
          alignment: const Alignment(0, -.12),
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: 50, maxHeight: 100, maxWidth: 500),
              child: Card(
                  color: Colors.lightBlue,
                  child: Center(
                      child: Text(
                    '1',
                  ))))),
    ),
    Container(
        child: Align(
            alignment: const Alignment(0, .44),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 50, maxHeight: 100, maxWidth: 500),
                child: Card(
                    color: Colors.lightBlueAccent,
                    child: Center(child: Text('2')))))),
    Container(
        child: Align(
            alignment: const Alignment(0, 1),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 50, maxHeight: 100, maxWidth: 500),
                child: Card(
                    color: Colors.lightBlue.shade700,
                    child: Center(
                        child: Text(
                      '3',
                    )))))),
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: titleSection,
    );
  }
}

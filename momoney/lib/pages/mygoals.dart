import 'package:flutter/material.dart';

class MyGoals extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoalsState();
  }
}

class _GoalsState extends State<MyGoals> {
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: <Widget>[
       Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Set Goal',
                      hintText: 'Enter Goal e.g. 200',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Create Goal',
                      hintText: 'Enter Goal e.g. 200',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            RaisedButton(
              color: Color(0xFF2196f3),
              textColor: Colors.white,
              child: Text('Save'),
              elevation: 5.0,
              onPressed: () {},
            )
          ],
        ),
      ),
    ]
    );
  }
}

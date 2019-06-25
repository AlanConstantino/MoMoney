import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex= 0;
  Widget callPage(int currentIndex){
    switch(_currentIndex){
      //this will how the pages get switched around.
      // future feature

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value){
          _currentIndex = value;
          setState(() {

          });
        },
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility),
          title: Text('My Profile'),

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_satisfied),
          title: Text('Goals'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_align_justify),
          title: Text('Settings'),
        )
      ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './myprofile.dart';
import './settings.dart';
import './mygoals.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final _pageOptions = [
        myprofile(),
        mygoals(),
        settings(),
      ];




    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar( automaticallyImplyLeading: false,title: Text('Dashboard'),),
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value){
          setState(() {
        _currentIndex = value;
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
      ),
    );
  }
}

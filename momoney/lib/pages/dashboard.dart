import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.accessibility),
          title: Text('My Profile'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.sentiment_satisfied),
          title: Text('Goals'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.format_align_justify),
          title: Text('Settings'),
        )
      ]),
    );
  }
}
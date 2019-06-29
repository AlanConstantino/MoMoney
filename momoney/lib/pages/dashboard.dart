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
        title: Text('Dashboard'),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(top: 40.0),
            children: <Widget>[
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Text('Hi');
                },
              ),
              ListTile(
                title: Text('Monthly Expenses'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Monthly Income'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Goals'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

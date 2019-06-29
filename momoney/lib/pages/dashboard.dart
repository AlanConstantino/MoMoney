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
              DrawerHeader(
              child: Text ("Your name here"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
          ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushNamed('/dashboard');
                },
              ),
              ListTile(
                title: Text('Monthly Expenses'),
                onTap: () {
                  Navigator.of(context).pushNamed('/dashboard');
                },
              ),
              ListTile(
                title: Text('Monthly Income'),
                onTap: () {
                  Navigator.of(context).pushNamed('/dashboard');
                },
              ),
              ListTile(
                title: Text('Goals'),
                onTap: () {
                  Navigator.of(context).pushNamed('/mygoals');
                },
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () {Navigator.of(context).pushNamed('/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

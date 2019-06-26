import 'package:flutter/material.dart';
import './MyProfile.dart';
import './settings.dart';
import './MyGoals.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final _pageOptions = [
    MyProfile(),
    MyGoals(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
            drawer: Drawer(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.only(top: 40.0),
                  children: <Widget>[
                    ListTile(
                      title: Text('Profile'),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Monthly Expenses'),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Monthly Income'),
                      onTap: (){
                        Navigator.push(context,
                         MaterialPageRoute(builder: (context){
                           return MyProfile();
                         }
                         ));
                      },
                    ),
                    ListTile(
                        title: Text('Goals'),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return MyGoals();
                        }
                        ));
                      }

                    ),
                    ListTile(
                      title: Text('Log Out'),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int value) {
            setState(() {
              _selectedIndex = value;
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

import 'package:flutter/material.dart';

import './my_plan.dart';
import './my_setting.dart';
import './my_dashboard.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()
  {
    return MyHomePage();
}
}


class MyHomePage extends State<MyApp> {
  //MyHomePage({Key key}) : super(key: key);
  int _selectedPage = 0;
  final _pageOptions = [
  my_Dashboard(),
  my_Plan(),
  my_setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Generated App',
        theme: new ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2196f3),
    accentColor: const Color(0xFF2196f3),
    canvasColor: const Color(0xFFfafafa),
    ),
      home: Scaffold(

        appBar: new AppBar(
          title: new Text('Welcome To MoMoney!'),
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              new BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("My Profile")
              ),
              new  BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility),
                  title: Text("My Plan")
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.format_align_justify),
                  title: Text("My Settings")
              ),
            ]
        )

    ),

    );}
}



import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp(
  ));
}
class MyApp extends StatelessWidget {

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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  final _pageOptions = [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    )

    );
  }
}



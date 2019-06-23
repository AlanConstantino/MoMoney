import 'package:flutter/material.dart';

//this ia another comment
// this is a test comment
void main() {
  runApp(new MyApp());
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome To MoMoney!'),
      ),
      bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.accessibility),
              title: new Text('My Profile'),
            ),

            new BottomNavigationBarItem(
              icon: const Icon(Icons.sentiment_satisfied),
              title: new Text('Goals'),
            ),

            new BottomNavigationBarItem(
              icon: const Icon(Icons.format_align_justify),
              title: new Text('Settings'),
            )
          ]

      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:momoney/pages/unused_pages/login.dart';
import 'package:momoney/pages/unused_pages/signup.dart';
import 'package:momoney/pages/dashboard.dart';
import 'package:momoney/pages/register.dart';
import 'package:momoney/pages/settings.dart';
import 'package:momoney/pages/mygoals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'MoMoney',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2196f3),
          accentColor: const Color(0xFF2196f3),
          canvasColor: const Color(0xFFfafafa),
        ),

        home: Register(),

        routes: {
          '/dashboard': (BuildContext context) => new Dashboard(),
          '/register': (BuildContext context) => new Register(),
          '/settings': (BuildContext context) => new Settings(),
          '/mygoals': (BuildContext context) => new MyGoals(),


          // may end up deleting the following later down the line
          '/login': (_) => Login(),
          '/signup': (_) => Signup(),
        });
  }}
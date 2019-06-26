import 'package:flutter/material.dart';

import 'package:momoney/pages/unused_pages/login.dart';
import 'package:momoney/pages/unused_pages/signup.dart';
import 'package:momoney/pages/dashboard.dart';
import 'package:momoney/pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Generated App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2196f3),
          accentColor: const Color(0xFF2196f3),
          canvasColor: const Color(0xFFfafafa),
        ),
        home: Register(),
        routes: {
          '/dashboard': (_) => Dashboard(),
          '/register': (_) => Register(),

          // may end up deleting the following later down the line
          '/login': (_) => Login(),
          '/signup': (_) => Signup(),
        });
  }}
import 'package:flutter/material.dart';
import './pages/dashboard.dart';
import './pages/login.dart';
import './pages/signup.dart';

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
      home: Login(),
      routes: {
        '/dashboard': (_) => Dashboard(),
        '/login': (_) => Login(),
        '/signup': (_) => Signup(),
      }
    );
  }
}
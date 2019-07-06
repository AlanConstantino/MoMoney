import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckIfReturningUser extends StatefulWidget {
  @override
  CheckIfReturningUserState createState() => CheckIfReturningUserState();
}

class CheckIfReturningUserState extends State<CheckIfReturningUser> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // uncomment the line below to clear the SharedPreferences cache

    // prefs.clear();

    bool returningUser = (prefs.getBool('seen') ?? false);

    if (returningUser) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed('/register');
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

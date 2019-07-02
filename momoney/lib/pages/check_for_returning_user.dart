import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:momoney/pages/register.dart';
import 'package:momoney/pages/dashboard.dart';

class CheckIfReturningUser extends StatefulWidget {
  @override
  CheckIfReturningUserState createState() => new CheckIfReturningUserState();
}

class CheckIfReturningUserState extends State<CheckIfReturningUser> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // uncomment the line below to clear the SharedPreferences cache
    
    // prefs.clear();

    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Register()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
    // new Timer(new Duration(milliseconds: 500), () {
    // checkFirstSeen();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return new Scaffold(
    return Center(
      child: Center(child: CircularProgressIndicator()),
      // ),
    );
  }
}

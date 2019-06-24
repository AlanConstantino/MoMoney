import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String username = '';
  String password = '';
  String monthlyIncome = '';
  String monthlyExpense = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Sign up'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Username field
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            //Password field
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            // Monthly Expense field
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      monthlyExpense = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(),
                    labelText: 'Monthly Expense',
                  ),
                ),
              ),
            ),
            // Monthly Income
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      monthlyIncome = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(),
                    labelText: 'Monthly Income',
                  ),
                ),
              ),
            ),
            // Button
              RaisedButton(
                color: Color(0xFF2196f3),
                textColor: Colors.white,
                child: Text('Sign up'),
                elevation: 5.0,
                onPressed: () =>
                    // check data against database
                    // if username matches one in database, error message
                    // if username doesn't match, allow user to go to their dashboard
                    Navigator.pushNamed(context, '/dashboard'),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(12.0),
                child: TextField(
                  autocorrect: false,
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
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(12.0),
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
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
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Color(0xFF2196f3),
                    textColor: Colors.white,
                    child: Text('Log in'),
                    elevation: 5.0,
                    onPressed: () =>
                        // check username against database
                        // if username matches, check password
                        // if both username and password match database, go to the dashboard
                        // if they don't match, display and error
                        Navigator.pushNamed(context, "/dashboard"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Color(0xFF2196f3),
                    textColor: Colors.white,
                    child: Text('Sign up'),
                    elevation: 5.0,
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    //Navigator.pushReplacementNamed(context, "/signup"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

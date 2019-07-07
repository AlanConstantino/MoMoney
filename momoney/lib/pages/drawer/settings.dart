import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final dbHelper = DatabaseHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context) {
    // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
    final snackbar = SnackBar(content: Text('All data has been deleted.'));
    // Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(snackbar);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(automaticallyImplyLeading: true, title: Text('Settings')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Delete All Data'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Are you sure?',
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          "Once all data is deleted it won't be recoverable and you will be returned to the register page.",
                        ),
                        actions: <Widget>[
                          FlatButton(
                            textColor: Colors.red,
                            child: Text('Delete'),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                dbHelper.deleteAllRows('income');
                                dbHelper.deleteAllRows('expense');
                              });
                              prefs.setDouble('monthlyIncome', 0.0);
                              prefs.setDouble('monthlyExpense', 0.0);
                              prefs.setInt('percentageToSaveMonthly', 0);
                              // await prefs.clear();
                              Navigator.of(context).pop();
                              _displaySnackBar(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

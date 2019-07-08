import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String previous, String current) {
    final snackbar = SnackBar(
        content: Text("Successfully changed '$previous' to '$current'"));
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  String firstName;
  String lastName;
  double monthlyIncome;
  double monthlyExpense;
  int percentageToSaveMonthly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: StatefulBuilder(
              builder: (context, setState) => Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          title: Text('Edit first name'),
                          trailing: Icon(Icons.create),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('First name'),
                                    content: TextField(
                                      onChanged: (value) {
                                        firstName = value;
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          String previous = preferences
                                              .getString('firstName');
                                          preferences.setString(
                                              'firstName', firstName);
                                          _displaySnackBar(
                                              context, previous, firstName);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Close"),
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
                      Card(
                        child: ListTile(
                          title: Text('Edit last name'),
                          trailing: Icon(Icons.create),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Last name'),
                                    content: TextField(
                                      onChanged: (value) {
                                        lastName = value;
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          String previous =
                                              preferences.getString('lastName');
                                          preferences.setString(
                                              'lastName', lastName);
                                          _displaySnackBar(
                                              context, previous, lastName);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Close"),
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
                      Card(
                        child: ListTile(
                          title: Text('Edit monthly income'),
                          trailing: Icon(Icons.create),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Monthly Income'),
                                    content: TextField(
                                      enableInteractiveSelection: false,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: true,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '0.00',
                                        prefixText: '\$',
                                      ),
                                      onChanged: (value) {
                                        monthlyIncome = double.parse(value);
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          String previous = preferences
                                              .getDouble('monthlyIncome')
                                              .toString();
                                          preferences.setDouble(
                                              'monthlyIncome', monthlyIncome);
                                          _displaySnackBar(context, previous,
                                              monthlyIncome.toString());
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Close"),
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
                      Card(
                        child: ListTile(
                          title: Text('Edit monthly expense'),
                          trailing: Icon(Icons.create),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Monthly Expense'),
                                    content: TextField(
                                      enableInteractiveSelection: false,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: true,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '0.00',
                                        prefixText: '\$',
                                      ),
                                      onChanged: (value) {
                                        monthlyExpense = double.parse(value);
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          String previous = preferences
                                              .getDouble('monthlyExpense')
                                              .toString();
                                          preferences.setDouble(
                                              'monthlyExpense', monthlyExpense);
                                          _displaySnackBar(context, previous,
                                              monthlyExpense.toString());
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Close"),
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
                      Card(
                        child: ListTile(
                          title: Text('Edit savings percentage'),
                          trailing: Icon(Icons.create),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Savings percentage'),
                                    content: Container(
                                      child: TextField(
                                        enableInteractiveSelection: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(signed: false),
                                        decoration: InputDecoration(
                                            hintText: '5%, 10%, 15%, etc.'),
                                        onChanged: (value) {
                                          percentageToSaveMonthly =
                                              int.parse(value);
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          String previous = preferences
                                              .getInt('percentageToSaveMonthly')
                                              .toString();
                                          preferences.setInt(
                                              'percentageToSaveMonthly',
                                              percentageToSaveMonthly);
                                          _displaySnackBar(
                                              context,
                                              previous,
                                              percentageToSaveMonthly
                                                  .toString());
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Close"),
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
                  )),
        ),
      ),
    );
  }
}

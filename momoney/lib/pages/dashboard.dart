import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.add),
            onSelected: (valueSelected) {
              switch (valueSelected) {
                case 'income':
                  Navigator.of(context).pushNamed('/add_income_form');
                  break;
                case 'expense':
                  Navigator.of(context).pushNamed('/add_expense_form');
                  break;
                default: // should never happen... hopefully...
                  print('Switch statement hit default case in dashbaord.dart');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                      value: 'income',
                      child: ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Income'),
                      )),
                  const PopupMenuItem<String>(
                    value: 'expense',
                    child: ListTile(
                      leading: Icon(Icons.money_off),
                      title: Text('Expense'),
                    ),
                  ),
                ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(top: 40.0),
            children: <Widget>[
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/profile');
                },
              ),
              ListTile(
                title: Text('Monthly Expenses'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/monthly_expenses');
                },
              ),
              ListTile(
                title: Text('Monthly Income'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/monthly_income');
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/settings');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text("Balance Left:"),
            subtitle: Text('200.00'),
          ))
        ]),
      ),
    );
  }
}

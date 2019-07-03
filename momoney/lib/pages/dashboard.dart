import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/user.dart';
import 'package:sqflite/sqflite.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //place holders, just preparing for the database connections
  double dummyMonthlyContribution = 200.00;
  double dummyUserGoal = 10000.00;
  double dummyIncome = 5000.00;
  double dummyExpenses = 600.00;
  double monthsLeft = 0.0;
  double dummyUserBalance = 400.0;
  double counter = 0;
  ListQueue listStack;

  Animation<Color> progressColor = AlwaysStoppedAnimation<Color>(Colors.green);

//test for list
  Key refreshKey = GlobalKey<RefreshIndicatorState>();

  get columnsToSelect => null; // list of expenses

  // ignore: unused_element
  Future<User> _query() async {
    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // get single row
    List<String> columnsToSelect = [
      DatabaseHelper.columnId,
      DatabaseHelper.columnFirstName,
      DatabaseHelper.columnLastName,
      DatabaseHelper.columnMonthlyIncome,
      DatabaseHelper.columnMonthlyExpense,
      DatabaseHelper.columnPercentageToSaveMonthly,
    ];

    String whereString = '${DatabaseHelper.columnId} = ?';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.query(DatabaseHelper.table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

    User user;
    result.forEach((row) => user = User.fromMap(row));
    return user;
  }

  @override
  void initState() {
    super.initState();
    listStack = new ListQueue();
    listStack.add("Pull to update");
  }

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
      body:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: refreshList,
            child:ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child:Align(
                       child: Text("Your Monthly Progress:")),
                    height: 60.0,
                  ),
                  Container(
                      child: SizedBox(
                          height: 20,
                          width: 300,
                          child: LinearProgressIndicator(
                            value: (dummyIncome -
                                dummyExpenses -
                                dummyMonthlyContribution) /
                                dummyUserGoal,
                            backgroundColor: Colors.red,
                            valueColor: progressColor,
                          ))
                  ),
                  Container(
                    alignment: Alignment(0, -.60),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Income",
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "\$" + dummyIncome.toStringAsFixed(2),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ), // Yellow
                    height: 60.0,
                  ),
                  Container(
                    alignment: Alignment(0, -.50),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text(
                        "Expenses ",
                        textAlign: TextAlign.left,
                      ),
                          Text(
                            "\$" + dummyExpenses.toStringAsFixed(2),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ), // Yellow
                    height: 60.0,

                  ),Container(alignment: Alignment(0, -.40),
                    child: SizedBox(
                        height: 40,
                        width: 300,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Monthly Contribution:", textAlign: TextAlign.left),
                            Text(
                              "\$" + dummyMonthlyContribution.toStringAsFixed(2),
                              textAlign: TextAlign.right,
                            )
                          ],
                        )), // Yellow
                    height: 60.0,
                  ),Container(
                  child:Align(
                  alignment: Alignment(0, -.3),
                  child: Divider(height: 3, color: Colors.black)) ,// Yellow
                    height: 60.0,
                  ),
                  Container(
                    alignment: Alignment(0, -.25),
                    child: SizedBox(
                        height: 40,
                        width: 300,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Balance Left Over",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "\$" +
                                    (dummyIncome -
                                        dummyExpenses -
                                        dummyMonthlyContribution)
                                        .toStringAsFixed(2),
                                textAlign: TextAlign.right,
                              ),
                            ])), // Yellow
                    height: 60.0,
                  ),
                  Container(
                      alignment: Alignment(0, .7),
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: ListView.builder(
                            itemCount: listStack.length,
                            itemBuilder: (context, i) => ListTile(
                              title: Text(listStack.elementAt(i)),
                            )),
                      )
                  ),
                  Container(
                    // A fixed-height child.
                    color: const Color(0xff808000), // Yellow
                    height: 120.0,
                  )
                ],
              ),
            )
            ));
        },
      ),
        bottomNavigationBar: Container(
          child: Row(children: <Widget>[
            Expanded(
                child: ListTile(
                  title: Text("Current Goal Balance:"),
                  subtitle: Text("\$" + ((dummyUserBalance)).toStringAsFixed(2)),
                )),
            Expanded(
              child: ListTile(
                title: Text("Months left until Goal:"),
                subtitle: Text(
                  ((dummyUserGoal - dummyUserBalance) / dummyMonthlyContribution)
                      .toString() +
                      " months",
                  textAlign: TextAlign.right,
                ),
              ),
            )
          ]),
        )
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      double d = counter++;
      String number = d.toString();
      listStack.addFirst("Expense/Income item " + number);
    });
    return null;
  }
}

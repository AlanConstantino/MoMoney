import 'dart:collection';

//import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

ListQueue listStack;
final dbHelper = DatabaseHelper.instance;

double dummyMonthlyContribution = 0.0;
double dummyUserGoal = 1.0;
double dummyIncome = 0.0;
double dummyExpenses = 0.0;
double monthsLeft = 0.0;
double dummyUserBalance = 0.0;
double counter = 0.0;

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

  void addExpense(double expenseAmount, String date, String description) {
    dummyExpenses -= expenseAmount;
    /*listStack.addFirst(ListTile(
      leading: Icon(
        Icons.remove,
        color: Colors.red,
      ),
      title: Text("-\$" + expenseAmount.toStringAsFixed(2)),
      trailing: Text(date),
      subtitle: Text(description),
    ));

     */
  }

  void addIncome(double incomeAmount, String date) {
    dummyIncome += incomeAmount;
    /*listStack.addFirst(ListTile(
      leading: Icon(
        Icons.add,
        color: Colors.green,
      ),
      title: Text("\$" + incomeAmount.toStringAsFixed(2)),
      trailing: Text(date),
    ));

     */
  }
}

class _DashboardState extends State<Dashboard> {
  //place holders, just preparing for the database connections
  Animation<Color> progressColor = AlwaysStoppedAnimation<Color>(Colors.green);

//test for list
  Key refreshKey = GlobalKey<RefreshIndicatorState>();

  get columnsToSelect => null; // list of expenses

  @override
  void initState() {
    addIncomeItem();
    addExpenseItem();
    getUserPrefs();
    super.initState();
    listStack = new ListQueue();
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
                    print(
                        'Switch statement hit default case in dashbaord.dart');
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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: RefreshIndicator(
                    onRefresh: refreshList,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            alignment: Alignment(0, .7),
                            child: SizedBox(
                              height: 400,
                              width: 400,
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                itemCount: listStack.length,
                                itemBuilder: (context, i) =>
                                    listStack.elementAt(i),
                              ),
                            ),
                            color: Colors.blue.shade100,
                          ),
                          Container(
                            child: Align(child: Text("Your Monthly Progress:")),
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
                                  ))),
                          Container(
                            alignment: Alignment(0, -.60),
                            child: SizedBox(
                              height: 40,
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                            height: 60.0,
                          ),
                          Container(
                            alignment: Alignment(0, -.50),
                            child: SizedBox(
                              height: 40,
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                            height: 60.0,
                          ),
                          Container(
                            alignment: Alignment(0, -.40),
                            child: SizedBox(
                                height: 40,
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Monthly Contribution:",
                                        textAlign: TextAlign.left),
                                    Text(
                                      "\$" +
                                          dummyMonthlyContribution
                                              .toStringAsFixed(2),
                                      textAlign: TextAlign.right,
                                    )
                                  ],
                                )),
                            height: 60.0,
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment(0, -.3),
                                child: Divider(height: 3, color: Colors.black)),
                            height: 20.0,
                          ),
                          Container(
                            alignment: Alignment(0, -.25),
                            child: SizedBox(
                                height: 40,
                                width: 300,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Balance Left Over",
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "\$" +
                                            (dummyIncome +
                                                    dummyExpenses -
                                                    dummyMonthlyContribution)
                                                .toStringAsFixed(2),
                                        textAlign: TextAlign.right,
                                      ),
                                    ])),
                            height: 60.0,
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment(0, -.3),
                                child: Divider(height: 5, color: Colors.black)),
                            height: 6.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text('Print user info to debug console'),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                // prints whatever the user entered in the registration page
                                print(
                                    '\nThe following is what was saved in shared preferences\n');
                                print(prefs.getString('firstName'));
                                print(prefs.getString('lastName'));
                                print(prefs.getDouble('monthlyIncome'));
                                print(prefs.getDouble('monthlyExpense'));
                                print(prefs.getInt('percentageToSaveMonthly'));

                                // User user = await _query();
                                // print(user.id);
                                // print(user.firstName);
                                // print(user.lastName);
                                // print(user.monthlyIncome);
                                // dummyUserBalance = user.monthlyIncome;
                                // print(user.monthlyExpense);
                                // dummyExpenses = user.monthlyExpense;
                                // print(user.percentageToSaveMonthly);
                                // dummyMonthlyContribution = dummyUserBalance *
                                //     user.percentageToSaveMonthly;
                              },
                            ),
                          ),
                        ],
                      ),
                    )));
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
                  ((dummyUserGoal - dummyUserBalance) /
                              dummyMonthlyContribution)
                          .toStringAsFixed(2) +
                      " months",
                  textAlign: TextAlign.right,
                ),
              ),
            )
          ]),
        ));
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      listStack.clear();

      addExpenseItem();
      addIncomeItem();
    });
    return null;
  }


  static Future<Null> getUserPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dummyIncome += prefs.get('monthlyIncome');
    dummyExpenses += prefs.get('monthlyExpense');
    dummyMonthlyContribution +=
        dummyIncome / prefs.get('percentageToSaveMonthly');
  }

  //Reloads the lists
  static Future<Null> addIncomeItem() async {
    var data = await dbHelper.queryAllRows('income');
    for (var item in data) {
      double amount = item['incomeAmount'];
      String date = item['dateAdded'];

      counter++;
      listStack.addFirst(ListTile(
        leading: Icon(
          Icons.add,
          color: Colors.green,
        ),
        title: Text( amount.toStringAsFixed(2)),
        trailing:  Text(date),
      ));
    }
  }

  static Future<Null> addExpenseItem() async {
    var data = await dbHelper.queryAllRows('expense');
    for (var item in data) {
      double amount = item['expenseAmount'];
      String date = item['dateAdded'];
      String description = item['description'];
      listStack.addFirst(ListTile(
        leading: Icon(
          Icons.remove,
          color: Colors.red,
        ),
        title: Text(amount.toStringAsFixed(2)),
        subtitle: Text(description),
        trailing: Text(date),
      ));
    }
  }
}

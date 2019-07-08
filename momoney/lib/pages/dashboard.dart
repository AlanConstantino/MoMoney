import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/expense.dart';
import 'package:momoney/model/income.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dbHelper = DatabaseHelper.instance;

  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double monthlyIncome = 0.0;
  double monthlyExpense = 0.0;
  double savingsPercentage = 0.0;
  double amountToSaveMonthly = 0.0;
  double balance = 0.0;
  double balanceLeftOver = 0.0;

  Animation<Color> progressColor = AlwaysStoppedAnimation<Color>(Colors.green);

  Future _initializeVariables() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var incomeData = await dbHelper.queryAllRows('income');
    var expenseData = await dbHelper.queryAllRows('expense');
    // [0] = income, [1] = expense, [2] = savingsPercentage
    // [3] = monthlyIncome, [4] = percentage
    var list = [0.0, 0.0, 0.0, 0.0, 0];

    // [0] = total income (double)
    for (var incomeMap in incomeData) {
      Income item = Income.fromMap(incomeMap);
      list[0] += item.incomeAmount;
    }

    // [1] = total expense (double)
    for (var expenseMap in expenseData) {
      Expense item = Expense.fromMap(expenseMap);
      list[1] += item.expenseAmount;
    }

    // [2] = monthlyIncome (double)
    list[2] = preferences.getDouble('monthlyIncome');

    // [3] = monthlyExpense (double)
    list[3] = preferences.getDouble('monthlyExpense');

    // [4] = percentage (int)
    list[4] = preferences.getInt('percentageToSaveMonthly');

    return list;
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
                        leading: Icon(Icons.attach_money, color: Colors.green),
                        title: Text('Add income'),
                      )),
                  const PopupMenuItem<String>(
                    value: 'expense',
                    child: ListTile(
                      leading: Icon(Icons.money_off, color: Colors.red),
                      title: Text('Add expense'),
                    ),
                  ),
                ],
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
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
                title: Text('Total Income'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/monthly_income');
                },
              ),
              ListTile(
                title: Text('Total Expenses'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/monthly_expenses');
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
      body: FutureBuilder(
        future: _initializeVariables(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          totalIncome = snapshot.data[0];
          totalExpense = snapshot.data[1];
          monthlyIncome = snapshot.data[2];
          monthlyExpense = snapshot.data[3];
          savingsPercentage = (snapshot.data[4] * 0.01);
          amountToSaveMonthly = savingsPercentage * monthlyIncome;
          balance = snapshot.data[0] - snapshot.data[1];
          balanceLeftOver =
              ((totalIncome - totalExpense) - amountToSaveMonthly);

          // double _getPercent(){
          //   // can't have negative values
          //   if((totalIncome - totalExpense).isNegative){
          //     return 0.0;
          //   }

          //   if((totalIncome - totalExpense) > monthlyIncome){
          //     return 1.0;
          //   }

          //   // zeros needed to multiply
          //   int length = monthlyIncome.toInt().toString().length - 2;


          //   return (totalIncome - totalExpense) * 0.001;
          // }
          

          return LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Align(
                        child: Text(
                          "Your Progress",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    // Container(
                    //   child: CircularPercentIndicator(
                    //     radius: 120.0,
                    //     lineWidth: 13.0,
                    //     animation: true,
                    //     animateFromLastPercent: true,
                    //     percent: _getPercent(),
                    //     center: Text(
                    //       '${(totalIncome - totalExpense).isNegative ? 0 : (totalIncome - totalExpense)}',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20.0,
                    //       ),
                    //     ),
                    //     circularStrokeCap: CircularStrokeCap.round,
                    //     progressColor: Colors.greenAccent,
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment(0, -.60),
                      child: SizedBox(
                        height: 40,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total Income",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "\$" + totalIncome.toStringAsFixed(2),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, -.50),
                      child: SizedBox(
                        height: 40,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Total Expenses ", textAlign: TextAlign.left),
                            Text(
                              "-\$" + totalExpense.toStringAsFixed(2),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, -.40),
                      child: SizedBox(
                          height: 40,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Savings goal:", textAlign: TextAlign.left),
                              Text(
                                  "\$" +
                                      (amountToSaveMonthly).toStringAsFixed(2),
                                  textAlign: TextAlign.right)
                            ],
                          )),
                    ),
                    Container(
                      child: Align(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                          width: 300,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Balance Left Over",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "\$" + balanceLeftOver.toStringAsFixed(2),
                                  textAlign: TextAlign.right,
                                ),
                              ])),
                    ),
                    Container(
                      child: SizedBox(
                          height: 160,
                          width: 300,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Current Balance",
                                  textAlign: TextAlign.left,
                                ),
                                Text("\$" + (balance).toStringAsFixed(2),
                                    textAlign: TextAlign.right),
                              ])),
                    ),
                  ],
                ),
              ));
            },
          );
        },
      ),
    );
  }
}

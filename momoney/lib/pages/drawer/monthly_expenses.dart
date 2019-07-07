import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/expense.dart';

class MonthlyExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonthlyExpensesState();
}

class _MonthlyExpensesState extends State<MonthlyExpenses> {
  final dbHelper = DatabaseHelper.instance;
  List<Expense> expenseList = [];

  Future<List<Expense>> _getExpenseData() async {
    var data = await dbHelper.queryAllRowsByDescending('expense');
    // List<Expense> list = [];

    for (var item in data) {
      Expense expense = Expense(item['_id'], item['expenseAmount'],
          item['description'], item['category'], item['dateAdded']);
      // list.add(income);
      expenseList.add(expense);
    }

    // return list;
    return expenseList;
  }

  // void dismissExpense(Expense expense) {
  //   // expenseList.forEach((n) => print(n.expenseAmount));
  //   if (expenseList.contains(expense)) {
  //     setState(() {
  //       expenseList.remove(expense);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Monthly Expenses'),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getExpenseData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                return ListView.builder(
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key(UniqueKey().toString()),
                          background: Container(
                            padding: EdgeInsets.only(left: 28.0),
                            alignment: AlignmentDirectional.centerStart,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                child: ListTile(
                                  // isThreeLine: true,
                                  leading: Icon(
                                    Icons.minimize,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                      '\$${expenseList[index].expenseAmount.toString()}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Text(snapshot.data[index].category),
                                      Text(expenseList[index].id.toString()),
                                      // Text('${snapshot.data[index].description}'),
                                    ],
                                  ),
                                  trailing: Text(expenseList[index].dateAdded),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Expense",
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                            'Amount: \$' +
                                                expenseList[index]
                                                    .expenseAmount
                                                    .toString() +
                                                '\n'
                                                    'Category: ' +
                                                expenseList[index].category +
                                                '\n'
                                                    'Date: ' +
                                                expenseList[index].dateAdded +
                                                '\n\n'
                                                    'Description:\n' +
                                                expenseList[index].description,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          onDismissed: (direction) {
                            // dismissExpense(expenseList[index]);
                          }
                          // setState(() {
                          //   dbHelper.delete('expense', snapshot.data[index].id);
                          //   expenseList.removeAt(index);
                          // });
                          // setState(() {
                          //   incomeList.removeAt(index);
                          //   dbHelper.delete('expense', snapshot.data[index].id);
                          //   snapshot.data.removeAt(index);
                          // });
                          // },
                          );
                    });
              }),
        ));
  }
}

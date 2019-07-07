import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/expense.dart';

class MonthlyExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonthlyExpensesState();
}

class _MonthlyExpensesState extends State<MonthlyExpenses> {
  final dbHelper = DatabaseHelper.instance;
  // List<Expense> incomeList = [];

  Future<List<Expense>> _getExpenseData() async {
    var data = await dbHelper.queryAllRowsByDescending('expense');
    List<Expense> list = [];

    for (var item in data) {
      Expense income = Expense(item['_id'], item['expenseAmount'],
          item['description'], item['category'], item['dateAdded']);
      list.add(income);
      // incomeList.add(income);
    }

    return list;
    // return incomeList;
  }

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
                    itemCount: snapshot?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ObjectKey(snapshot.data[index].id),
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
                                    '\$${snapshot.data[index].expenseAmount.toString()}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(snapshot.data[index].category),
                                    // Text('${snapshot.data[index].description}'),
                                  ],
                                ),
                                trailing: Text(snapshot.data[index].dateAdded),
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
                                          'Amount: \$' + snapshot.data[index].expenseAmount.toString() + '\n'
                                          'Category: ' + snapshot.data[index].category + '\n'
                                          'Date: ' + snapshot.data[index].dateAdded + '\n\n'
                                          'Description:\n' + snapshot.data[index].description,
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
                          // setState(() {
                          //   incomeList.removeAt(index);
                          //   dbHelper.delete('expense', snapshot.data[index].id);
                          //   snapshot.data.removeAt(index);
                          // });
                        },
                      );
                    });
              }),
        ));
  }
}
